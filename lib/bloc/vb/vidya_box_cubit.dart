import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../data/services/repository/MiscRepository.dart';

part 'vb_state.dart';

class VidyaBoxCubit extends Cubit<VbState> {
  VidyaBoxCubit() : super(VbState());
  MiscRepository _miscRepository = GetIt.I<MiscRepository>();

  fetchVidyaBoxSlides() async {
    log("Testing1");
    try {
      emit(state.copyWith(slidesLoading: SlidesLoading.loading));
      final slides = await _miscRepository.fetchVidyaBoxSlides();
      print(slides);
      if (slides is List<VidyaBoxSlide>) {
        emit(state.copyWith(slidesLoading: SlidesLoading.fetched, vidyaboxSlides: slides));
      }else{
        log("Something wents wrong");
      }
    } catch (e) {
      emit(state.copyWith(slidesLoading: SlidesLoading.error));
    }
  }

}
