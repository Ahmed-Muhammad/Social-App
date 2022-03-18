abstract class LoginStates {}

//------------------Login State-----------
class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates
{
  final String? uid ;

  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates {
final String? error;

  LoginErrorState(this.error);
}

//------------------Change Password Visibility State-----------

class LoginChangePasswordVisibilityState extends LoginStates {}

//------------------CacheHelperSaveDataState-----------
class CacheHelperSaveDataState extends LoginStates {}
