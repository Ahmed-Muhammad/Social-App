import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practicing/core/shared/constant.dart';
import 'package:firebase_practicing/models/user%20model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chats/chats_screen.dart';
import '../../feeds/feeds_screen.dart';
import '../../new_post/new_post.dart';
import '../../settings/settings_screen.dart';
import '../../users/users_screen.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore
        .instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((value)
    {
      print('User Information: => ${value.data()}');

      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());

    }).catchError((error)
    {
      emit(SocialGetUserErrorState(error.toString()));
      print('Error getUserData => ' + error.toString());
    });
  }

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
}
