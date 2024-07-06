part of 'subscription_cubit.dart';

enum SubscriptionListStatus { initial, loading, fetched }

enum UserSubscriptionStatus { initial, loading, fetched }

class SubscriptionState {
  final SubscriptionListStatus subscriptionListStatus;
  final UserSubscriptionStatus? userSubscriptionStatus;
  final V3Subscription? subscriptionTypes;
  final UserSubscription? userSubscription;
  final ReferenceCode? referenceCode;

  SubscriptionState({
    this.subscriptionListStatus = SubscriptionListStatus.initial,
    this.subscriptionTypes,
    this.userSubscription,
    this.userSubscriptionStatus = UserSubscriptionStatus.initial,
    this.referenceCode,
  });

  SubscriptionState copyWith(
      {SubscriptionListStatus? subscriptionListStatus,
      V3Subscription? subscriptionTypes,
      UserSubscription? userSubscription,
      UserSubscriptionStatus? userSubscriptionStatus,
      ReferenceCode? referenceCode,
      String? bannerUrl}) {
    return SubscriptionState(
      subscriptionListStatus: subscriptionListStatus ?? this.subscriptionListStatus,
      subscriptionTypes: subscriptionTypes ?? this.subscriptionTypes,
      userSubscription: userSubscription ?? this.userSubscription,
      userSubscriptionStatus: userSubscriptionStatus ?? this.userSubscriptionStatus,
      referenceCode: referenceCode ?? this.referenceCode,
    );
  }
}
