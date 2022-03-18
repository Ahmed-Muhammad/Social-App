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

  void createUser({
    required String? email,
    required String? phone,
    required String? uid,
    required String? name,
  }) {
    emit(RegisterLoadingState());
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        isEmailVerified: false);
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

  IconData suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;
    suffix = obscureText
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

//   late String verificationId;
//
//   void submitPhoneNumber({required String? phoneNumber}) async {
//     emit(VerifyPhoneLoadingState());
//
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+2$phoneNumber',
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     );
//   }
//
// //في حاله ان الموبايل قرأ الكود لوحده
//   void verificationCompleted(PhoneAuthCredential credential) {
//     print("Verification completed");
//     submit(credential);
//   }
//
//   void verificationFailed(FirebaseAuthException error) {
//     print("VerificationFailed+ ${error.toString}");
//     emit(VerifyPhoneErrorState(error.toString()));
//   }
//
//   void codeSent(String verificationId, int? resendToken) {
//     print("CodeSent");
//     this.verificationId = verificationId;
//     emit(VerifyPhoneSubmittedState());
//   }
//
//   void codeAutoRetrievalTimeout(String verificationId) {
//     print("codeAutoRetrievalTimeout");
//   }
//
//   submitOTP(String otpCode) async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId, smsCode: otpCode);
//     submit(credential);
//   }
//
//   void submit(PhoneAuthCredential credential) {
//     FirebaseAuth.instance.signInWithCredential(credential).then((value) {
//       emit(VerifyPhoneOTPState());
//     }).catchError((error) {
//       emit(VerifyPhoneErrorState(error.toString()));
//     });
//   }
//
//   void logOut() async {
//     print("logOut");
//     await FirebaseAuth.instance.signOut();
//   }
//
//   User? getLoggedInUser() {
//     User? firebaseUser = FirebaseAuth.instance.currentUser;
//     return firebaseUser;
//   }
}
