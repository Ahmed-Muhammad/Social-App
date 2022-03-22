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

class SocialProfileImagePickedSuccessState extends SocialState {}
class SocialProfileImagePickedErrorState extends SocialState {}

class SocialCoverImagePickedSuccessState extends SocialState {}
class SocialCoverImagerPickedErrorState extends SocialState {}


class SocialUpdateProfileImageSuccessState extends SocialState {}
class SocialUpdateProfileImageErrorState extends SocialState {}


class SocialUpdateCoverImageSuccessState extends SocialState {}
class SocialUpdateCoverImageErrorState extends SocialState {}

class SocialUserUpdateErrorState extends SocialState {}
class SocialUserUpdateLoadingState extends SocialState {}