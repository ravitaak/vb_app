// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:vb_app/data/services/models/V2Chapter.dart';
import 'package:vb_app/data/services/models/district.dart';
import 'package:vb_app/data/services/models/registration_body.dart' as Auth;
import 'package:vb_app/data/services/models/states.dart';
import 'package:vb_app/data/services/models/trial_data.dart';
import 'package:vb_app/data/services/repository/PublicRepository.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalState()) {
    Connectivity().onConnectivityChanged.listen((result) {
      emit(state.copyWith(online: !(result.contains(ConnectivityResult.none))));
    });
  }

  PublicRepository _publicRepository = GetIt.I<PublicRepository>();

  updateRegistrationBody(Auth.RegistrationBody body) async {
    emit(state.copyWith(registrationBody: body));
  }

  hideBadgeOnPremium() {
    emit(state.copyWith(showBadgeOnPremium: false));
  }

  setRegistrationBodyLang(String lang) {
    emit(state.copyWith(registrationBody: state.registrationBody!.copyWith(lang: lang)));
  }

  togglePremiumFAB(bool value) {
    emit(state.copyWith(premiumScreenFABVisible: value));
  }

  setOfferButton(bool val) {
    emit(state.copyWith(showOfferButton: val));
  }

  Future getCacheValues(String key) async {
    try {
      final value = await _publicRepository.getCacheValue(key);
      emit(state.copyWith(cacheValues: state.cacheValues.copyWith(DOWNLOADS_REQUIRED_TO_REDEEM: value)));
    } catch (e) {
      return null;
    }
  }

  resetDistrict() {
    emit(state.copyWith(registrationBody: state.registrationBody!.resetDistrict()));
  }

  getVisibleClasses() async {
    try {} catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
    }
  }

  getChapterPrice() async {
    try {
      emit(state.copyWith(chapterPriceStatus: ChapterPriceStatus.loading));
      final int chapterPrice = jsonDecode(await _publicRepository.getSettingsValue("CHAPTER_PRICE"));
      emit(state.copyWith(chapterPrice: chapterPrice, chapterPriceStatus: ChapterPriceStatus.fetched));
    } catch (e, stacktrace) {
      emit(state.copyWith(chapterPriceStatus: ChapterPriceStatus.error));
      log(e.toString(), stackTrace: stacktrace);
    }
  }

  getWatchAdStatus() async {
    try {
      emit(state.copyWith(watchAdButtonStatus: WatchAdButtonStatus.loading));
      final String? watchAds = await _publicRepository.getSettingsValue("WATCH_ADS_FOR_CHAPTER");
      emit(state.copyWith(
          watchAdButtonStatus: watchAds == null
              ? WatchAdButtonStatus.show
              : watchAds == "1"
                  ? WatchAdButtonStatus.show
                  : WatchAdButtonStatus.hide));
    } catch (e, stacktrace) {
      emit(state.copyWith(watchAdButtonStatus: WatchAdButtonStatus.show));
      log(e.toString(), stackTrace: stacktrace);
    }
  }

  beforePlayerAudioPrompt() async {
    try {
      //result -> "https://?=....,<audio_length_in_seconds>"
      final String? audioPrompt = await _publicRepository.getSettingsValue("AUDIO_PROMPT");
      emit(state.copyWith(audioPrompt: audioPrompt));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getInitialAdVideo() async {
    try {
      return await _publicRepository.getSettingsValue("INITIAL_AD_VIDEO");
    } catch (e) {
      log(e.toString(), name: "getInitialAdVideo");
      return null;
    }
  }

  showVideoBeforePremium() async {
    try {
      //result -> "https://youtube.com/v?=....,<skip_time_in_seconds>"
      return await _publicRepository.getSettingsValue("VIDEO_BEFORE_PREMIUM");
    } catch (e) {
      log(e.toString(), name: "VIDEO_BEFORE_PREMIUM");
      return null;
    }
  }

  Future showFailurePossibilityDialog() async {
    try {
      final val = await _publicRepository.getSettingsValue("FAILURE_POSSIBILITY_DIALOG");
      return val == "1";
    } catch (e, s) {
      log(e.toString(), stackTrace: s, name: "showFailurePossibilityDialog");
      return false;
    }
  }

  Future showRecurringPaymentInfoDialog() async {
    try {
      final val = await _publicRepository.getSettingsValue("DIALOG_BEFORE_RECURRING_PAYMENT");
      return val == "1"
          ? true
          : val == "0"
              ? false
              : val;
    } catch (e, s) {
      log(e.toString(), stackTrace: s, name: "showFailurePossibilityDialog");
      return false;
    }
  }

  getPremiumScreenVersion() async {
    try {
      final int _version = jsonDecode(await _publicRepository.getSettingsValue("PREMIUM_SCREEN_VERSION"));
      emit(state.copyWith(premiumScreenVersion: _version));
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
    }
  }

  Future getStates() async {
    try {
      final states = await _publicRepository.getStates();
      emit(state.copyWith(states: states));
    } catch (e) {
      log(e.toString());
    }
  }

  Future getDistrict(int stateId) async {
    try {
      emit(state.copyWith(districtStatus: DistrictStatus.loading));
      final List<District> districts = await _publicRepository.getDistricts(stateId);
      districts.sort((a, b) {
        return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
      });
      emit(state.copyWith(district: districts, districtStatus: DistrictStatus.fetched));
    } catch (e) {
      print(e);
    }
  }

  toggleGovernmentTabGridView() {
    emit(state.copyWith(governmentTabGridView: !state.governmentTabGridView));
  }

  toggleBeyondAcademicsTabGridView() {
    emit(state.copyWith(beyondAcademicsTabGridView: !state.beyondAcademicsTabGridView));
  }

  togglePodcastTabGridView() {
    emit(state.copyWith(podcastTabGridView: !state.podcastTabGridView));
  }

  setExploreScreenTabIndex(int index) {
    emit(state.copyWith(exploreScreenTabIndex: index));
  }

  updateBoards(List<String> val) {
    emit(state.copyWith(selectedBoards: val));
  }

  toggleSearchBox() {
    emit(state.copyWith(searchBoxOpen: !state.searchBoxOpen!));
  }

  Future getPopUp() async {
    try {
      final _response = await _publicRepository.getCacheValue("POPUP");
      return _response;
    } catch (e) {
      return null;
    }
  }

  setGlobalContext(BuildContext context) {
    emit(state.copyWith(globalContext: context));
  }

  Future getSurvey(int user) async {
    try {
      final _response = await _publicRepository.getSurvey(user);
      if (_response is! int) {
        emit(state.copyWith(surveyBody: _response["survey_body"], surveyId: _response["id"]));
      }
    } catch (e) {
      log(e.toString(), name: "getSurvey");
    }
  }

  requestAdForChapter(int user, String uid, int? chapter, int source) {
    _publicRepository.requestAdForChapter({"uid": uid, "user": user, "chapter": chapter, "source": source});
  }

  updateRequestAdForChapter(String uid, bool watchedAd, {String? remarks}) {
    _publicRepository.updateRequestAdForChapter({"uid": uid, "watchedAd": watchedAd, "remarks": remarks});
  }
}
