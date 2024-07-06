// ignore_for_file: must_be_immutable

part of 'global_cubit.dart';

enum DistrictStatus { initial, loading, fetched }

enum LinkStatsStatus { initial, loading, fetched }

enum StoriesStatus { initial, loading, fetched }

enum RandomSubscribersStatus { initial, loading, fetched, error }

enum ChapterPriceStatus { initial, loading, fetched, error }

enum WatchAdButtonStatus { initial, loading, show, hide }

enum VBImagesLoadingStatus { initial, loading, fetched, error }

enum ReferralAssetLoadingStatus { initial, loading, fetched, error }

@immutable
class GlobalState extends Equatable {
  GlobalState({
    this.globalContext,
    this.states,
    this.lectures,
    this.bookName,
    this.bookImage,
    this.chapter,
    this.searchBoxOpen = false,
    this.searching = false,
    this.guid,
    this.district,
    this.districtStatus = DistrictStatus.loading,
    this.registrationBody,
    this.exploreScreenText,
    this.exploreScreenTextRedirectTo,
    this.trialData,
    this.cacheValues = const CacheValues(),
    this.linkStatsStatus = LinkStatsStatus.initial,
    this.showOfferButton = true,
    this.premiumScreenFABVisible = true,
    this.trialExpired = false,
    this.online = true,
    this.visibleClasses = const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16],
    this.surveyBody,
    this.surveyId,
    this.storiesStatus = StoriesStatus.initial,
    this.randomSubscribersStatus = RandomSubscribersStatus.initial,
    this.premiumScreenVersion,
    this.chapterPrice,
    this.chapterPriceStatus,
    this.vbImages,
    this.vbImagesLoadingStatus = VBImagesLoadingStatus.initial,
    this.customAds = false,
    this.watchAdButtonStatus = WatchAdButtonStatus.initial,
    this.audioPrompt,
    this.beyondAcademicsTabGridView = true,
    this.governmentTabGridView = true,
    this.podcastTabGridView = true,
    this.exploreScreenTabIndex = 0,
    this.showBadgeOnPremium = true,
    this.selectedBoards = const [],
    this.referralAssetLoadingStatus = ReferralAssetLoadingStatus.initial,
  });
  final List<File>? vbImages;
  final BuildContext? globalContext;
  final bool showOfferButton;
  final List<States>? states;
  final List<District>? district;
  final DistrictStatus districtStatus;
  final Lectures? lectures;
  final String? bookName;
  final String? bookImage;
  final V2Chapter? chapter;
  final bool? searchBoxOpen;
  final bool? searching;
  final String? guid;
  final Auth.RegistrationBody? registrationBody;
  final String? exploreScreenText;
  final String? exploreScreenTextRedirectTo;
  final TrialData? trialData;
  final CacheValues cacheValues;
  final LinkStatsStatus? linkStatsStatus;
  final bool premiumScreenFABVisible;
  final bool trialExpired;
  final bool online;
  final List<int> visibleClasses;
  Map<String, dynamic>? surveyBody;
  int? surveyId;
  final StoriesStatus storiesStatus;
  final RandomSubscribersStatus? randomSubscribersStatus;
  final int? premiumScreenVersion;
  final int? chapterPrice;
  final ChapterPriceStatus? chapterPriceStatus;
  final VBImagesLoadingStatus? vbImagesLoadingStatus;
  final bool? customAds;
  final WatchAdButtonStatus? watchAdButtonStatus;
  final String? audioPrompt;
  final bool governmentTabGridView;
  final bool beyondAcademicsTabGridView;
  final bool podcastTabGridView;
  final int exploreScreenTabIndex;
  final bool? showBadgeOnPremium;
  final List<String> selectedBoards;
  final ReferralAssetLoadingStatus referralAssetLoadingStatus;

  setSurveyNull() {
    surveyId = null;
    surveyBody = null;
  }

  // copyWith

  GlobalState copyWith({
    List<File>? vbImages,
    BuildContext? globalContext,
    bool? showOfferButton,
    List<States>? states,
    List<District>? district,
    DistrictStatus? districtStatus,
    Lectures? lectures,
    String? bookName,
    String? bookImage,
    V2Chapter? chapter,
    bool? searchBoxOpen,
    bool? searching,
    String? guid,
    Auth.RegistrationBody? registrationBody,
    String? exploreScreenText,
    String? exploreScreenTextRedirectTo,
    TrialData? trialData,
    CacheValues? cacheValues,
    LinkStatsStatus? linkStatsStatus,
    bool? premiumScreenFABVisible,
    bool? trialExpired,
    bool? online,
    List<int>? visibleClasses,
    Map<String, dynamic>? surveyBody,
    int? surveyId,
    StoriesStatus? storiesStatus,
    RandomSubscribersStatus? randomSubscribersStatus,
    int? premiumScreenVersion,
    int? chapterPrice,
    ChapterPriceStatus? chapterPriceStatus,
    VBImagesLoadingStatus? vbImagesLoadingStatus,
    bool? customAds,
    WatchAdButtonStatus? watchAdButtonStatus,
    String? audioPrompt,
    bool? governmentTabGridView,
    bool? beyondAcademicsTabGridView,
    bool? podcastTabGridView,
    int? exploreScreenTabIndex,
    bool? showBadgeOnPremium,
    List<String>? selectedBoards,
    ReferralAssetLoadingStatus? referralAssetLoadingStatus,
  }) {
    return GlobalState(
      vbImages: vbImages ?? this.vbImages,
      globalContext: globalContext ?? this.globalContext,
      showOfferButton: showOfferButton ?? this.showOfferButton,
      states: states ?? this.states,
      district: district ?? this.district,
      districtStatus: districtStatus ?? this.districtStatus,
      lectures: lectures ?? this.lectures,
      bookName: bookName ?? this.bookName,
      bookImage: bookImage ?? this.bookImage,
      chapter: chapter ?? this.chapter,
      searchBoxOpen: searchBoxOpen ?? this.searchBoxOpen,
      searching: searching ?? this.searching,
      guid: guid ?? this.guid,
      registrationBody: registrationBody ?? this.registrationBody,
      exploreScreenText: exploreScreenText ?? this.exploreScreenText,
      exploreScreenTextRedirectTo: exploreScreenTextRedirectTo ?? this.exploreScreenTextRedirectTo,
      trialData: trialData ?? this.trialData,
      cacheValues: cacheValues ?? this.cacheValues,
      linkStatsStatus: linkStatsStatus ?? this.linkStatsStatus,
      premiumScreenFABVisible: premiumScreenFABVisible ?? this.premiumScreenFABVisible,
      trialExpired: trialExpired ?? this.trialExpired,
      online: online ?? this.online,
      visibleClasses: visibleClasses ?? this.visibleClasses,
      surveyBody: surveyBody ?? this.surveyBody,
      surveyId: surveyId ?? this.surveyId,
      storiesStatus: storiesStatus ?? this.storiesStatus,
      randomSubscribersStatus: randomSubscribersStatus ?? this.randomSubscribersStatus,
      premiumScreenVersion: premiumScreenVersion ?? this.premiumScreenVersion,
      chapterPrice: chapterPrice ?? this.chapterPrice,
      chapterPriceStatus: chapterPriceStatus ?? this.chapterPriceStatus,
      vbImagesLoadingStatus: vbImagesLoadingStatus ?? this.vbImagesLoadingStatus,
      customAds: customAds ?? this.customAds,
      watchAdButtonStatus: watchAdButtonStatus ?? this.watchAdButtonStatus,
      audioPrompt: audioPrompt ?? this.audioPrompt,
      governmentTabGridView: governmentTabGridView ?? this.governmentTabGridView,
      beyondAcademicsTabGridView: beyondAcademicsTabGridView ?? this.beyondAcademicsTabGridView,
      podcastTabGridView: podcastTabGridView ?? this.podcastTabGridView,
      exploreScreenTabIndex: exploreScreenTabIndex ?? this.exploreScreenTabIndex,
      showBadgeOnPremium: showBadgeOnPremium ?? this.showBadgeOnPremium,
      selectedBoards: selectedBoards ?? this.selectedBoards,
      referralAssetLoadingStatus: referralAssetLoadingStatus ?? this.referralAssetLoadingStatus,
    );
  }

  @override
  List<Object?> get props {
    return [
      states,
      lectures,
      bookName,
      bookImage,
      chapter,
      searchBoxOpen,
      searching,
      guid,
      district,
      districtStatus,
      registrationBody,
      exploreScreenText,
      exploreScreenTextRedirectTo,
      trialData,
      linkStatsStatus,
      showOfferButton,
      premiumScreenFABVisible,
      trialExpired,
      online,
      visibleClasses,
      surveyBody,
      surveyId,
      storiesStatus,
      randomSubscribersStatus,
      premiumScreenVersion,
      chapterPrice,
      vbImages,
      chapterPriceStatus,
      vbImagesLoadingStatus,
      customAds,
      watchAdButtonStatus,
      audioPrompt,
      podcastTabGridView,
      beyondAcademicsTabGridView,
      governmentTabGridView,
      exploreScreenTabIndex,
      globalContext,
      showBadgeOnPremium,
      selectedBoards,
      referralAssetLoadingStatus,
    ];
  }
}

class CacheValues {
  final int? DOWNLOADS_REQUIRED_TO_REDEEM;

  const CacheValues({this.DOWNLOADS_REQUIRED_TO_REDEEM});

  CacheValues copyWith({int? DOWNLOADS_REQUIRED_TO_REDEEM}) {
    return CacheValues(DOWNLOADS_REQUIRED_TO_REDEEM: DOWNLOADS_REQUIRED_TO_REDEEM ?? this.DOWNLOADS_REQUIRED_TO_REDEEM);
  }
}
