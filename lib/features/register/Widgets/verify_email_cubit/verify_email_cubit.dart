import 'package:firebase_practicing/features/register/Widgets/verify_email_cubit/verify_email_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VerifyEmailCubit extends Cubit<VerifyEmailStates> {
  VerifyEmailCubit() : super(VerifyEmailInitialState());

//------عشان اعرف استدعي ال cubit بطريقه بسيطه في اي مكان  -----
  static VerifyEmailCubit get(context) => BlocProvider.of(context);



  //---------------Change Password Visibility -------------------
  IconData suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(VerifyEmailChangePasswordVisibilityState());
  }
}
