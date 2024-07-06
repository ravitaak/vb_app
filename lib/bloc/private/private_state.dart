// ignore_for_file: must_be_immutable

part of 'private_cubit.dart';

enum EventState { initial, loading, fetched }

enum CouponsState { initial, loading, fetched }

enum VerifyCouponState { initial, loading, verified, error }

class PrivateState extends Equatable {
  final Map<int, List<V2Chapter>?>? chapterMap;

  final String? liveRoomAccessToken;
  final EventState eventState;
  final List<Coupon>? coupons;
  final CouponsState couponsState;
  final VerifyCouponState? verifyCouponState;
  Coupon? currentAppliedCoupon;

  PrivateState(
      {this.chapterMap,
      this.liveRoomAccessToken,
      this.eventState = EventState.initial,
      this.coupons,
      this.couponsState = CouponsState.initial,
      this.verifyCouponState = VerifyCouponState.initial,
      this.currentAppliedCoupon});

  removeCoupon() {
    this.currentAppliedCoupon = null;
    return this;
  }

  PrivateState copyWith({
    Map<int, List<V2Chapter>?>? chapterMap,
    String? liveRoomAccessToken,
    EventState? eventState,
    List<Coupon>? coupons,
    CouponsState? couponsState,
    VerifyCouponState? verifyCouponState,
    Coupon? currentAppliedCoupon,
  }) {
    return PrivateState(
      chapterMap: chapterMap ?? this.chapterMap,
      liveRoomAccessToken: liveRoomAccessToken ?? this.liveRoomAccessToken,
      eventState: eventState ?? this.eventState,
      coupons: coupons ?? this.coupons,
      couponsState: couponsState ?? this.couponsState,
      verifyCouponState: verifyCouponState ?? this.verifyCouponState,
      currentAppliedCoupon: currentAppliedCoupon ?? this.currentAppliedCoupon,
    );
  }

  @override
  List<Object?> get props => [chapterMap, liveRoomAccessToken, eventState, coupons, couponsState, verifyCouponState, currentAppliedCoupon];
}
