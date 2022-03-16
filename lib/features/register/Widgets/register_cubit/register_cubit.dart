import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

//------عشان اعرف استدعي ال cubit بطريقه بسيطه في اي مكان  -----
  static RegisterCubit get(context) => BlocProvider.of(context);

  //-----------------register user-----------------


  void userRegister({
    required String email,
    required String phone,
    required String password,
    required String name,
  }) {
    emit(RegisterLoadingState());

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
