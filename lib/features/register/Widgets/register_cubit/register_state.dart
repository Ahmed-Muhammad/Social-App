abstract class RegisterStates {}

//------------------Register State-----------
class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class CreateUserSuccessState extends RegisterStates {}
class CreateUserErrorState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {

}

//------------------Change Password Visibility State-----------

class RegisterChangePasswordVisibilityState extends RegisterStates {}

//------------------CacheHelperSaveDataState-----------
class CacheHelperSaveDataState extends RegisterStates {}

//-------------Verify phone number-----------------------------
class VerifyPhoneLoadingState extends RegisterStates {}

class VerifyPhoneSubmittedState extends RegisterStates {}

class VerifyPhoneErrorState extends RegisterStates
{
  final String? error;

  VerifyPhoneErrorState(this.error);
}

class VerifyPhoneOTPState extends RegisterStates {}

