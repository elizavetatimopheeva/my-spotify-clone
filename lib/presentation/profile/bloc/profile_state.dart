import 'package:spotify/domain/entities/auth/user.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity userEntity;

  ProfileLoaded({required this.userEntity});
}

class ProfileFailure extends ProfileState {}
