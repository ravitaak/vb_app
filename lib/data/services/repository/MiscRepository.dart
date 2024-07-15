// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:vb_app/data/services/Constants.dart';
import 'package:vb_app/data/services/interceptors.dart';
import 'package:vb_app/data/services/models/Coupon.dart';
import 'package:vb_app/data/services/models/V2Chapter.dart';
import 'package:vb_app/data/services/models/V3Subscription.dart';
import 'package:vb_app/data/services/models/razorpay_order.dart';
import 'package:vb_app/data/services/models/razorpay_subscription.dart';
import 'package:vb_app/data/services/models/reference_code.dart';
import 'package:vb_app/data/services/models/user_subscription.dart';
import 'package:vb_app/utils/SecureStorage.dart';

import '../../../bloc/vb/vidya_box_cubit.dart';
import '../models/vidyabox_slides.dart';


class MiscRepository {
  Dio _dio = GetIt.I<Dio>();

  MiscRepository() {
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor(_dio));
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future validate(Map<String, dynamic> body) async {
    try {
      await _dio.post(ApiConstants.version1.validate, data: body);
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return false;
      }
      return true;
    }
  }

  Future shippingAddress(Map<String, dynamic> body) async {
    try {
      Response res = await _dio.post(ApiConstants.version1.shippingAddress, data: body);
      return res;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return false;
      }
      return true;
    }
  }

  getPreSignedUrl(String path, String filename) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.getPreSignedUrl, data: {"path": 'app-data/hiring-assets', "filename": filename});

      return _response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future sendFile(String url, File file) async {
    try {
      final fileBytes = await file.readAsBytes();
      final response = await http.put(Uri.parse(url), headers: {'Content-Type': 'application/octet-stream'}, body: fileBytes);

      if (response.statusCode == 200) {
        return url.split("?").first;
      } else {
        return null;
      }
    } on DioException catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future submitTeacherSchoolForm(data) async {
    try {
      await _dio.post(ApiConstants.version1.teacherAndSchoolForm, data: data);
    } catch (e) {
      log(e.toString(), name: "submitTeacherSchoolForm");
    }
  }

  createVbDemoOrder(data) async {
    _dio.post(ApiConstants.version1.vbDemo, data: data);
  }

  Future<List<String>> getVBMandateAddons() async {
    try {
      Response response = await _dio.get(ApiConstants.version1.getSettingValues("VB_ADDONS"));
      List _availableAddons = List.from(response.data.where((e) => e["app"] && e["value"] != null).toList());
      return _availableAddons.map<String>((e) => e["value"]).toList();
    } catch (e) {
      log(e.toString());
      return <String>[];
    }
  }

  Future<List<String>> getMandateAddons() async {
    try {
      Response response = await _dio.get(ApiConstants.version1.getSettingValues("SUB_ADDONS"));
      return response.data.map<String>((e) => e["value"] && e["app"]).toList;
    } catch (e) {
      return <String>[];
    }
  }
  getFreeDemoUrl() async {
    try {
      Response response = await _dio.get(ApiConstants.version1.getSettingValues("REQUEST_DEMO"));
      return response.data['btnUrl'];
    } catch (e) {
      return 'Url not Fectched';
    }
  }

  postResultsToDB(data) async {
    try {
      await _dio.post(ApiConstants.version1.saveExamResponse, data: data);
    } catch (e) {
      rethrow;
    }
  }

  getNumberOfAvailableQuestionForChapter(int chapter) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.availableQBankForChapter(chapter));
      return jsonDecode(_response.data);
    } catch (e) {
      rethrow;
    }
  }

  saveAddress(data) async {
    Response response = await _dio.post(ApiConstants.version1.saveAddress, data: data);
    return response.data;
  }

  updateAddress(data) async {
    Response response = await _dio.put(ApiConstants.version1.saveAddress, data: data);
    return response.data;
  }

  updateUser(data) async {
    Response response = await _dio.put(ApiConstants.version1.updateUser, data: data);
    return response.data;
  }

  postComment(data) async {
    Response _resp = await _dio.post(ApiConstants.version1.postComment, data: data);
    return jsonDecode(_resp.data);
  }

  postRating(data) async {
    await _dio.post(ApiConstants.version1.postRating, data: data);
  }

  getCouponCode() async {
    try {
      Response response = await _dio.get(ApiConstants.version1.coupon);
      return response.data.map<Coupon>((c) => Coupon.fromJson(c)).toList();
    } catch (e) {
      rethrow;
    }
  }

  getReferenceCodeDetails(String code) async {
    try {
      Response response = await _dio.get(ApiConstants.version1.getReferenceCodeDetails(code.toUpperCase()));
      return ReferenceCode.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  validateCouponCode(data) async {
    try {
      Response response = await _dio.post(ApiConstants.version1.validateCoupon, data: data);
      return Coupon.fromJson(response.data);
    } catch (e) {
      log(e.toString(), name: "validateCouponCode");
      return null;
    }
  }

  createOrderRazorpay(int amount, int user, int sub, {int? coupon, bool? vb = false, bool upi = false, String? selectedClass, String? medium}) async {
    try {
      Response response = await _dio.post(ApiConstants.version1.createRazorpayOrder, data: {
        "amount": amount,
        "user": user,
        "sub": sub,
        "coupon": coupon,
        "withOrder": vb,
        "class": selectedClass,
        "medium": medium,
        "upi": upi
      });
      return RazorpayOrder.fromJson(response.data);
    } on DioException catch (e) {
      return e.response?.data?["message"];
    }
  }

  Future<RazorpaySubscription?> createSubscriptionOrderRazorpay(data) async {
    try {
      log(data.toString(), name: "createSubscriptionOrderRazorpay data log");
      Response response = await _dio.post(ApiConstants.version1.rzpCreateSubscriptionOrder, data: data);
      return RazorpaySubscription.fromJson(response.data);
    } catch (e, s) {
      log(e.toString(), stackTrace: s, name: "Razorpay order creation");
      return null;
    }
  }

  createOrderRazorpayForChapter(int amount, int user, int chapter, {bool upi = false}) async {
    try {
      Response response =
          await _dio.post(ApiConstants.version1.createRazorpayOrderForBook, data: {"amount": amount, "user": user, "chapter": chapter, "upi": upi});
      return RazorpayOrder.fromJson(response.data);
    } catch (e) {
      log(e.toString(), name: "Razorpay book order creation");
      return null;
    }
  }

  Future getUserChapter(int user, int chapter) async {
    try {
      Response response = await _dio.get(ApiConstants.version1.getUserChapter(chapter, user));
      return response.data;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        return null;
      }
      log(e.response?.data.toString() ?? e.message.toString(), name: "getUserChapter");
    }
  }

  pingLastSeen(int user) {
    _dio.put(ApiConstants.version1.ping, data: {"id": user, "last_seen": DateTime.now().toString()});
  }

  Future getChaptersByBook(int bookId) async {
    try {
      log(ApiConstants.version1.getChaptersByBook(bookId));
      log(_dio.options.headers["Authorization"]);
      Response _response = await _dio.get(ApiConstants.version1.getChaptersByBook(bookId));
      return _response.data["chapter"].map<V2Chapter>((e) => V2Chapter.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future createSubscription(Map<String, dynamic> data) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.createSubscription, data: data);
      if (_response.data["statusCode"] == 201) {
        return _response.data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future buyBooks({required int user, required List<int> books, String? paymentId, required int total}) async {
    try {
      await _dio.post(ApiConstants.version1.buyBooks, data: {"user": user, "books": books, "paymentId": paymentId, "total": total});
    } catch (e) {
      rethrow;
    }
  }

  Future getSubscription(int user) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.getSubscription(user));
      return UserSubscription.fromJson(_response.data);
      // return UserSubscription.fromJson(jsonDecode(
      //     """{"id":22479,"paymentStatus":true,"amount":119,"createdAt":"2023-12-13T23:18:51.037Z","user":{"id":159977,"fullname":"ishika Sharma "},"sub":{"id":6,"name":"Monthly App","duration":30}}"""));
    } catch (e) {
      return null;
    }
  }

  Future getSubscriptionWithTimeOut(int user) async {
    try {
      _dio.get(ApiConstants.version1.getSubscription(user)).timeout(Duration(seconds: 100)).then((_response) async {
        await SecureStorage.setValue(key: "OFFLINE_SUB", value: "false");
        return UserSubscription.fromJson(_response.data);
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future fetchAllSubscriptions(String createdAt) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.fetchSubscriptions(createdAt));
      return V3Subscription.fromJson(_response.data);
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future countInEvent(int user, int event) async {
    await _dio.post(ApiConstants.version1.countInEvent(user, event));
  }

  Future boughtChapter(int chapter, int user) async {
    try {
      Response resp = await _dio.get(ApiConstants.version1.getUserChapter(chapter, user));
      return resp.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return -1;
      }
    }
  }

  Future podcastEpisodesBought(int podcast, int podcastIndex) async {
    try {
      Response resp = await _dio.get(ApiConstants.version1.podcastEpisodesBought(podcast, podcastIndex));
      return resp.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      } else {
        return -1;
      }
    }
  }

  Future getToken(int eventId) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.getToken(eventId));
      return _response.data;
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future updateEventStatus(int eventCode, int statusCode) async {
    try {
      await _dio.put(ApiConstants.version1.updateStatus(eventCode, statusCode));
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future createEvent(Map<String, dynamic> data) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.createEvent, data: data);
      return _response.data["statusCode"];
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future updateAnswerForJob(List<String> answers, int applicationId) async {
    try {
      await _dio.put(ApiConstants.version1.updateAnswerForJob, data: {"answers": answers, "id": applicationId});
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future applyApplication(data) async {
    try {
      await _dio.post(ApiConstants.version1.applyToJob, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future createApplication(int userId, int jobId) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.createApplication, data: {"user": userId, "job": jobId});
      return jsonDecode(_response.data);
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future onBoardSchool(data) async {
    try {
      await _dio.post(ApiConstants.version1.schoolOnBoard, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future savePhoneNumbers(data) async {
    try {
      await _dio.post(ApiConstants.version1.savePhoneNumbers, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future isAccountAlive(int user) async {
    try {
      await _dio.get(ApiConstants.version1.isAccountAlive(user));
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      }
      return true;
    }
  }

  deleteAccount(int user) async {
    try {
      Response response = await _dio.delete(ApiConstants.version1.deleteAccount(user));
      return response.data;
    } catch (e) {
      log(e.toString(), name: "Delete Account");
    }
  }

  fetchVidyaBoxSlides() async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.vidyaboxSlides);
      return _response.data['slides'].map<VidyaBoxSlide>((e) => VidyaBoxSlide.fromJson(e)).toList();
    } on DioException catch (e) {
      log(e.message!, name: "fetchVidyaBoxSlides");
      return -1;
    }
  }

  addToCart(int item, int user) async {
    try {
      Response response = await _dio.post(ApiConstants.version1.addToCart, data: {"user": user, "qty": 1, "product": item});

      return response.data["cartId"];
    } on DioException catch (e) {
      log(e.message!, name: "addToCart");

      return -1;
    }
  }

  updateQty(int cart, int product, int qty) async {
    try {
      await _dio.put(ApiConstants.version1.updateQty, data: {"cart": cart, "product": product, "qty": qty});
    } on DioException catch (e) {
      log(e.message!, name: "addToCart");

      return -1;
    }
  }

  removeFromCart(int cartId, int productId) async {
    try {
      await _dio.delete(ApiConstants.version1.removeFromCart, data: {"cart": cartId, "product": productId});
    } on DioException catch (e) {
      log(e.message!, name: "removeFromCart");

      return -1;
    }
  }
}
