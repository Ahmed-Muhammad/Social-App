import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practicing/core/shared/constant.dart';
import 'package:firebase_practicing/models/post%20model/user_model.dart';
import 'package:firebase_practicing/models/user%20model/user_model.dart';
import 'package:flutter/cupertino.dart';
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

  List<CreatePostModel> posts = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
      .then((value)
      {
        for (var element in value.docs) 
        {
          posts.add(CreatePostModel.fromJson(element.data()));
        }

        emit(SocialGetPostsSuccessState());
      }
      ).catchError((error)
      {
        emit(SocialGetPostsErrorState(error.toString()));
      });
  }
}
