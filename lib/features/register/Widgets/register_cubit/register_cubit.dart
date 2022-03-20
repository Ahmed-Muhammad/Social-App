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
          image: 'https://scontent.fcai21-2.fna.fbcdn.net/v/t1.6435-9/36137473_1672721836179430_3456862169725927424_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=9tYeesdPuIQAX_nct-b&_nc_ht=scontent.fcai21-2.fna&oh=00_AT_wYM67ZUr4i1_q3WIfrJiwIzcEaIsW6YPg5hvUhRhMuQ&oe=625A1564',
          uid: value.user!.uid,
          name: name,
          cover:
          'https://images.pexels.com/photos/256273/pexels-photo-256273.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
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
    required String? cover,
    required String? image,
  }) {
    emit(RegisterLoadingState());
    UserModel userModel = UserModel(
      name: name,
      bio: 'Write your bio ...',
      image: 'https://scontent.fcai21-2.fna.fbcdn.net/v/t1.6435-9/36137473_1672721836179430_3456862169725927424_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=9tYeesdPuIQAX_nct-b&_nc_ht=scontent.fcai21-2.fna&oh=00_AT_wYM67ZUr4i1_q3WIfrJiwIzcEaIsW6YPg5hvUhRhMuQ&oe=625A1564',
      email: email,
      phone: phone,
      uid: uid,
      isEmailVerified: false,
      cover:
          'https://images.pexels.com/photos/256273/pexels-photo-256273.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
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

  IconData suffix = Icons.visibility_outlined;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined;
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
