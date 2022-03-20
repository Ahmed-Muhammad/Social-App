part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}


class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPostState extends SocialState {}
