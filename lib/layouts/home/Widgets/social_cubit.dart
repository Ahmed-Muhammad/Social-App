import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practicing/core/shared/constant.dart';

import 'package:firebase_practicing/models/message%20model/message_model.dart';
import 'package:firebase_practicing/models/post%20model/user_model.dart';
import 'package:firebase_practicing/models/user%20model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage;

import '../../chats/chats_screen.dart';
import '../../feeds/feeds_screen.dart';
import '../../new_post/new_post.dart';
import '../../settings/settings_screen.dart';
import '../../users/users_screen.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

//---------------change Bottom Navigation bar--------------------

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  var titles = [
    'Home',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getAllUser();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

//---------------Get User Data Cache--------------------
//   getUserDataCache({
//     bool? image,
//     bool? cover,
//     bool? name,
//     bool? bio,
//   }) {
//     CacheHelper.saveData(key: 'image', value: userModel!.image!);
//     CacheHelper.saveData(key: 'cover', value: userModel!.cover!);
//     CacheHelper.saveData(key: 'name', value: userModel!.name!);
//     CacheHelper.saveData(key: 'bio', value: userModel!.bio!);
//     if (image == true) {
//       return cacheImage = CacheHelper.getData(key: 'image');
//     } else if (cover == true) {
//       return cacheImage = CacheHelper.getData(key: 'cover');
//     } else if (name == true) {
//       return cacheImage = CacheHelper.getData(key: 'name');
//     } else {
//       return cacheImage = CacheHelper.getData(key: 'bio');
//     }
//   }

//---------------Get User Data--------------------

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      // print('User Information: => ${value.data()}');

      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
      print('Error getUserData => ' + error.toString());
    });
  }

//---------------Get Profile Image--------------------
  File? profileImage;

  Future getProfileImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage(
        name: name,
        phone: phone,
        bio: bio,
      );
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected ');
      emit(SocialProfileImagePickedErrorState());
    }
  }

//---------------Upload Profile Image--------------------
  String? profileImageUrl = '';

  void uploadProfileImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        //ref() عشان ادخل جواه المسار | child() عشان اشوف هيتحرك ازاي جواه
        .ref()
        .child(
            'users/Profile Images/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((downloadURL) {
        emit(SocialUpdateProfileImageSuccessState());
        print("getDownloadURL ==>" + downloadURL);

        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: downloadURL,
        );
      }).catchError((error) {
        emit(SocialUpdateProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUpdateProfileImageErrorState());
    });
  }

//---------------Get Cover Image --------------------
  File? coverImage;

  Future getCoverImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadCoverImage(name: name, phone: phone, bio: bio);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected ');
      emit(SocialCoverImagerPickedErrorState());
    }
  }

//---------------Upload Cover Image ---------------

  void uploadCoverImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        //ref() عشان ادخل جواه المسار | child() عشان اشوف هيتحرك ازاي جواه
        .ref()
        .child(
            'users/Cover Images/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((downloadURL) {
        emit(SocialUpdateCoverImageSuccessState());
        print("getDownloadURL ==>" + downloadURL);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: downloadURL,
        );
      }).catchError((error) {
        emit(SocialUpdateCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUpdateCoverImageErrorState());
    });
  }

//---------------Update User Data--------------------

  void updateUserData({
    required String? name,
    required String? phone,
    required String? bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUserUpdateLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      uid: userModel!.uid!,
      image: image ?? userModel!.image!,
      cover: cover ?? userModel!.cover!,
      email: userModel!.email!,
      bio: bio,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid!)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
      print(error.toString());
    });
  }

//---------------Get Post Image--------------------
  File? postImage;

  Future getPostImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);

      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected ');
      emit(SocialPostImagePickedErrorState());
    }
  }

//---------------remove Post Image--------------------

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

//---------------upload Post Image--------------------

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((downloadURL) {
        emit(SocialUpdateCoverImageSuccessState());

        createPost(
          dateTime: dateTime,
          text: text,
          postImage: downloadURL,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

//---------------create new post--------------------

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialUserUpdateLoadingState());
    CreatePostModel postModel = CreatePostModel(
      name: userModel!.name,
      image: userModel!.image,
      uid: userModel!.uid,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

//--------------- get Posts in feeds screens--------------------



  List<int> likes = [];
  List<int> comments = [];

  List postsId = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          comments.add(value.docs.length);
          POSTS.add(CreatePostModel.fromJson(element.data()));
          //get post Id
          postsId.add(element.id);

          print('length in cubit   ${POSTS.length}');
        }).catchError((error) {});
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

//---------------likes toggle ----------------

  void likePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid!)
        .set({'like': true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState());
    });
  }

  //--------------comments----------------------

  void postComment({required String? comment, required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uid!)
        .set({'comment': comment}).then((value) {
      emit(SocialCommentPostsSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostsErrorState());
    });
  }

  //-----------get Align user Data-----------

  List<UserModel> users = [];

  void getAllUser() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          {
            //عشان ما اجبش بياناتي انا  في chats
            if (element.data()['uid'] != userModel!.uid) {
              users.add(UserModel.fromJson(element.data()));
            }
          }
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  //-----------------send Message  ---------------------

  void sendMessage({
    required String? receiverId,
    required String? dateTime,
    required String? message,
    String? image,
  }) {
    MessageModel messageModel = MessageModel(
      message: message,
      senderId: userModel!.uid!,
      dateTime: dateTime,
      receiverId: receiverId,
      image: image,
    );
    //set sender chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid!)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());

    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  //-----------------get Message  ---------------------



  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      MESSAGES = [];
      for (var element in event.docs) {
        MESSAGES.add(MessageModel.fromJson(element.data()));
      }

    });
    emit(SocialGetMessagesSuccessState());

  }
}
