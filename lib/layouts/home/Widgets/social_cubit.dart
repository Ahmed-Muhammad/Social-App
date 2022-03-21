import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practicing/core/shared/constant.dart';
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
  List<Widget> screens = const [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
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

//---------------get Profile Image--------------------
  File? profileImage;

  Future getProfileImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected ');
      emit(SocialProfileImagePickedErrorState());
    }
  }

//---------------get Cover Image--------------------
  File? coverImage;

  Future getCoverImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected ');
      emit(SocialCoverImagerPickedErrorState());
    }
  }

//---------------upload Profile Image--------------------

  String? profileImageUrl = '';

  void uploadProfileImage() {
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
        profileImageUrl = downloadURL;
      }).catchError((error) {
        emit(SocialUpdateProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUpdateProfileImageErrorState());
    });
  }

//---------------upload Cover Image--------------------

  String? coverImageUrl = '';
  void uploadCoverImage() {
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
        coverImageUrl = downloadURL;
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
  }) {


    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      uid: uid,
      bio: bio,
      isEmailVerified: false,
      image: profileImageUrl,
      cover: coverImageUrl,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid!)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }
}
