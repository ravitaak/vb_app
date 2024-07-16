import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:vb_app/data/database/db.dart';
import 'package:vb_app/data/services/repository/MiscRepository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoading());
  MiscRepository _miscRepository = GetIt.I<MiscRepository>();

  setUserData(TbUserData userData) {
    emit(new UserLoaded(userData: userData));
  }

  Future updateUser(data) async {
    final resp = await _miscRepository.updateUser(data);
    return resp;
  }
}
