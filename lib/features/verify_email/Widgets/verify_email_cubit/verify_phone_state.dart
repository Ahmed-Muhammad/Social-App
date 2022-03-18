abstract class VerifyEmailStates {}

//------------------VerifyEmail State-----------
class VerifyEmailInitialState extends VerifyEmailStates {}

class VerifyEmailLoadingState extends VerifyEmailStates {}

class VerifyEmailSuccessState extends VerifyEmailStates {}

class VerifyEmailErrorState extends VerifyEmailStates {
  final String error;

  VerifyEmailErrorState(this.error);
}

//------------------Change Password Visibility State-----------

class VerifyEmailChangePasswordVisibilityState extends VerifyEmailStates {}

//------------------CacheHelperSaveDataState-----------
class CacheHelperSaveDataState extends VerifyEmailStates {}

//----------------------------------------------------------
