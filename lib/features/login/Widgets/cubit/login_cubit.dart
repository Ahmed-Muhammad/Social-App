import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

//------عشان اعرف استدعي ال cubit بطريقه بسيطه في اي مكان  -----
  static LoginCubit get(context) => BlocProvider.of(context);

  //-------------------------------login function --------------
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError));
    });
  }

  //---------------Change Password Visibility -------------------
  IconData suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}
