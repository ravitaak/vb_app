import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vb_app/bloc/user/user_cubit.dart';
import 'package:vb_app/data/services/models/V3Subscription.dart';
import 'package:vb_app/data/services/models/razorpay_subscription.dart';
import 'package:vb_app/data/services/models/reference_code.dart';
import 'package:vb_app/data/services/models/user_subscription.dart';
import 'package:vb_app/data/services/repository/MiscRepository.dart';
import 'package:vb_app/utils/SecureStorage.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final UserCubit userCubit;
  SubscriptionCubit(this.userCubit) : super(SubscriptionState());
  MiscRepository _miscRepository = GetIt.I<MiscRepository>();

  Future createRazorpayOrder(int amount, int user, int sub,
      {int? coupon, bool upi = false, bool? vb = false, String? selectedClass, String? medium}) async {
    return await _miscRepository.createOrderRazorpay(amount, user, sub, coupon: coupon, upi: upi);
  }

  Future<RazorpaySubscription?> createRazorpaySubscriptionOrder(int amount, int user, int sub,
      {int? coupon, bool vb = false, String? selectedClass, String? medium, String? addons, int? sub_start_at, int? total_count}) async {
    try {
      Map<String, dynamic> _body = {};
      if (addons != null && addons.isNotEmpty) {
        _body.addAll({"addons": jsonDecode(addons)});
      }
      if (sub_start_at != null) {
        _body.addAll({"startAfter": sub_start_at});
      }
      if (vb) {
        _body = {..._body, "withOrder": true, "class": selectedClass, "medium": medium};
      }

      return await _miscRepository
          .createSubscriptionOrderRazorpay({..._body, "amount": amount, "sub": sub, "user": user, "total_count": total_count});
    } catch (e, s) {
      log(e.toString(), name: "createRazorpaySubscriptionOrder", stackTrace: s);
      return null;
    }
  }

  Future createRazorpayOrderForChapter(int amount, int user, int chapter, {bool upi = false}) async {
    try {
      return await _miscRepository.createOrderRazorpayForChapter(amount, user, chapter, upi: upi);
    } catch (e) {
      log(e.toString(), name: "createRazorpayOrderForChapter");
    }
  }

  Future getSubscriptionDetails() async {
    try {
      log("getSubscriptionDetails called");
      Stopwatch stopwatch = Stopwatch()..start();
      emit(state.copyWith(userSubscriptionStatus: UserSubscriptionStatus.loading));
      UserLoaded _userLoaded = userCubit.state as UserLoaded;
      log("user id ${_userLoaded.userData!.id}");

      UserSubscription? _sub = await _miscRepository.getSubscription(_userLoaded.userData!.id);
      if (_sub == null) {
        emit(
          state.copyWith(userSubscriptionStatus: UserSubscriptionStatus.fetched, userSubscription: null),
        );
      } else {
        emit(
          state.copyWith(userSubscriptionStatus: UserSubscriptionStatus.fetched, userSubscription: _sub),
        );
        await SecureStorage.setValue(key: "SUBSCRIPTION", value: jsonEncode(_sub.toJson()));
      }

      stopwatch.stop();
    } catch (e, s) {
      log("${e.toString()}\n${s.toString()}", name: "getSubscriptionDetails");
    }
  }

  Future getSubscriptionDetailsWithTimeOut() async {
    try {
      log("getSubscriptionDetails called");
      Stopwatch stopwatch = Stopwatch()..start();

      emit(state.copyWith(userSubscriptionStatus: UserSubscriptionStatus.loading));
      UserLoaded _userLoaded = userCubit.state as UserLoaded;
      log("user id ${_userLoaded.userData!.id}");
      String? _subb = await SecureStorage.getValue(key: "SUBSCRIPTION");
      _subb = jsonDecode(_subb!);
      if (_subb != null || _subb != "") {
        UserSubscription? _sub = UserSubscription.fromJson(_subb);
        emit(
          state.copyWith(userSubscriptionStatus: UserSubscriptionStatus.fetched, userSubscription: _sub),
        );
        await SecureStorage.setValue(key: "OFFLINE_SUB", value: "true");
      }

      UserSubscription? _sub = await _miscRepository.getSubscriptionWithTimeOut(_userLoaded.userData!.id);
      if (_sub == null) {
        emit(
          state.copyWith(userSubscriptionStatus: UserSubscriptionStatus.fetched, userSubscription: null),
        );
      } else {
        emit(
          state.copyWith(userSubscriptionStatus: UserSubscriptionStatus.fetched, userSubscription: _sub),
        );
        await SecureStorage.setValue(key: "SUBSCRIPTION", value: jsonEncode(_sub.toJson()));
      }

      stopwatch.stop();
      log('time elapsed ${stopwatch.elapsed}', name: "getSubscriptionDetails");
    } catch (e, s) {
      log("${e.toString()}\n${s.toString()}", name: "getSubscriptionDetails");
    }
  }

  Future getReferenceCodeDetails(String code) async {
    try {
      ReferenceCode? _referenceCode = await _miscRepository.getReferenceCodeDetails(code);
      emit(state.copyWith(referenceCode: _referenceCode));
      if (_referenceCode != null) {
        await SecureStorage.setValue(key: "REFERENCE_CODE", value: jsonEncode(_referenceCode.toJson()));
      }
    } catch (e, stacktrace) {
      log("${e}\n$stacktrace", name: "getReferenceCodeDetails");
    }
  }

  Future getSubscriptionsList(String createdAt) async {
    try {
      emit(state.copyWith(subscriptionListStatus: SubscriptionListStatus.loading));
      V3Subscription _subTypes = await _miscRepository.fetchAllSubscriptions(createdAt);

      _subTypes.subscription!.sort((a, b) => a.position!.compareTo(b.position!));

      emit(state.copyWith(subscriptionListStatus: SubscriptionListStatus.fetched, subscriptionTypes: _subTypes));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }

  setSubscriptionList(V3Subscription sub) {
    emit(state.copyWith(subscriptionTypes: sub));
  }

  Future saveSubscription(int subscriptionId,
      {double? amount,
      bool success = true,
      String? remarks,
      bool withOrder = false,
      String? paymentId,
      String? ios_app_user_id,
      String? kClass,
      String? medium}) async {
    UserLoaded _userLoaded = userCubit.state as UserLoaded;
    await _miscRepository.createSubscription({
      "paymentId": paymentId,
      "sub": subscriptionId,
      "user": _userLoaded.userData!.id,
      "amount": amount,
      "paymentStatus": success,
      "remarks": remarks,
      "withOrder": withOrder,
      "class": kClass,
      "medium": medium,
      "ios_app_user_id": ios_app_user_id,
      "paid_through": Platform.isAndroid ? 0 : 1
    });
    await getSubscriptionDetails();
  }
}
