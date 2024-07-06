// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:vb_app/bloc/user/user_cubit.dart';
import 'package:vb_app/data/services/models/Coupon.dart';
import 'package:vb_app/data/services/models/V2Chapter.dart';
import 'package:vb_app/data/services/repository/MiscRepository.dart';

part 'private_state.dart';

class PrivateCubit extends Cubit<PrivateState> {
  final UserCubit userCubit;
  PrivateCubit(this.userCubit) : super(PrivateState());

  MiscRepository _miscRepository = GetIt.I<MiscRepository>();

  Future saveAddress(data) async {
    var resp = await _miscRepository.saveAddress(data);
    // if(resp == 'ok') return true;
    return resp;
  }

  Future updateAddress(data) async {
    var resp = await _miscRepository.updateAddress(data);
    // if(resp == 'ok') return true;
    return resp;
  }

  Future getCouponCode() async {
    try {
      emit(state.copyWith(couponsState: CouponsState.loading));
      List<Coupon> coupon = await _miscRepository.getCouponCode();
      emit(state.copyWith(coupons: coupon, couponsState: CouponsState.fetched));
    } catch (e) {
      log(e.toString(), name: "getCouponCode");
    }
  }

  setCoupon(Coupon c) {
    emit(state.copyWith(currentAppliedCoupon: c, verifyCouponState: VerifyCouponState.verified));
  }

  removeCoupon() {
    emit(state.copyWith(verifyCouponState: VerifyCouponState.initial).removeCoupon());
  }

  Future validateCouponCode(data) async {
    try {
      emit(state.copyWith(verifyCouponState: VerifyCouponState.loading));
      final result = await _miscRepository.validateCouponCode(data);
      if (result != null && result is Coupon) {
        emit(state.copyWith(verifyCouponState: VerifyCouponState.verified, currentAppliedCoupon: result));
      } else {
        emit(state.copyWith(verifyCouponState: VerifyCouponState.error));
      }
    } catch (e) {
      log(e.toString(), name: "validateCouponCode");
    }
  }

  Future chapterBought(int chapter, int user) async {
    return await _miscRepository.boughtChapter(chapter, user);
  }

  Future podcastEpisodesBought(int podcast, int podcastIndex) async {
    return await _miscRepository.podcastEpisodesBought(podcast, podcastIndex);
  }

  Future getToken(int eventId) async {
    try {
      return await _miscRepository.getToken(eventId);
    } catch (e) {
      print(e);
    }
  }

  pingLastSeen(int user) {
    try {
      _miscRepository.pingLastSeen(user);
    } catch (e) {
      print(e);
    }
  }
}
