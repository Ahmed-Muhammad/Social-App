import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practicing/models/user%20model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

//------عشان اعرف استدعي ال cubit بطريقه بسيطه في اي مكان  -----
  static RegisterCubit get(context) => BlocProvider.of(context);

  //-----------------register user-----------------

  void createUser({
    required String email,
    required String phone,
    required String uid,
    required String name,
  }) {
    emit(RegisterLoadingState());
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateUserErrorState());

    });
  }

  void userRegister({
    required String email,
    required String phone,
    required String password,
    required String name,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        createUser(
          email: email,
          phone: phone,
          uid: value.user!.uid,
          name: name,
        );
        emit(RegisterSuccessState());
        print(value.user!.email);
        print(value.user!.uid);
        print(value.user!.emailVerified);
      },
    ).catchError(
      (error) {
        print(error.toString);
        emit(RegisterErrorState());
      },
    );
  }

  //-----------------Send Verify Email-----------------

  // SendVerifyEmailModel? sendVerifyEmailModel;

  // void sendVerifyEmail({
  //   required String email,
  // }) {
  //   DioHelper.postData(
  //     url: VerifyEmail,
  //     data: {'email': email},
  //   ).then((value) {
  //     sendVerifyEmailModel = SendVerifyEmailModel.fromJson(value.data);
  //     print(value.data.toString());
  //     emit(SuccessVerifyEmailState());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(ErrorVerifyEmailState());
  //   });
  // }

  //---------------Change Password Visibility -------------------
  IconData suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
