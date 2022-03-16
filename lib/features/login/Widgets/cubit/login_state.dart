abstract class LoginStates {}

//------------------Login State-----------
class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {

}

//------------------Change Password Visibility State-----------

class LoginChangePasswordVisibilityState extends LoginStates {}

//------------------CacheHelperSaveDataState-----------
class CacheHelperSaveDataState extends LoginStates {}
