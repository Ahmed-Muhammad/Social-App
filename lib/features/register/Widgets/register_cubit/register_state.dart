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

//-------------Verify ------------
class LoadingVerifyEmailState extends RegisterStates {}

class SuccessVerifyEmailState extends RegisterStates {}

class ErrorVerifyEmailState extends RegisterStates {}
