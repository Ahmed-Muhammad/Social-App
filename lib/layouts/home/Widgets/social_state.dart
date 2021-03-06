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


class SocialGetAllUsersLoadingState extends SocialState {}
class SocialGetAllUsersSuccessState extends SocialState {}
class SocialGetAllUsersErrorState extends SocialState {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}



class SocialGetPostsLoadingState extends SocialState {}
class SocialGetPostsSuccessState extends SocialState {}
class SocialGetPostsErrorState extends SocialState {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostsSuccessState extends SocialState {}
class SocialLikePostsErrorState extends SocialState {

}
class SocialCommentPostsSuccessState extends SocialState {}
class SocialCommentPostsErrorState extends SocialState {

}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPostState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}
class SocialProfileImagePickedErrorState extends SocialState {}

class SocialCoverImagePickedSuccessState extends SocialState {}
class SocialCoverImagerPickedErrorState extends SocialState {}


class SocialPostImagePickedSuccessState extends SocialState {}
class SocialPostImagePickedErrorState extends SocialState {}

class SocialUpdateProfileImageSuccessState extends SocialState {}
class SocialUpdateProfileImageErrorState extends SocialState {}


class SocialUpdateCoverImageSuccessState extends SocialState {}
class SocialUpdateCoverImageErrorState extends SocialState {}

class SocialUserUpdateErrorState extends SocialState {}
class SocialUserUpdateLoadingState extends SocialState {}

class SocialCreatePostLoadingState extends SocialState {}
class SocialCreatePostSuccessState extends SocialState {}
class SocialCreatePostErrorState extends SocialState {}
class SocialRemovePostImageState extends SocialState {}

class SocialSendMessageSuccessState extends SocialState {}
class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessagesSuccessState extends SocialState {}
class SocialGetMessagesLoadingState extends SocialState {}
