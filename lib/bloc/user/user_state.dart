part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();
}

class UserLoaded extends UserState {
  const UserLoaded({this.userData});
  final TbUserData? userData;

  @override
  List<Object?> get props => [userData];
}

class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object?> get props => [];
}
