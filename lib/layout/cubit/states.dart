abstract class AppStates {}

class InitialState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserLoadingState extends AppStates {}

class GetUserErrorState extends AppStates {
  final String error;

  GetUserErrorState(this.error);
}

class ChangeBottomNavState extends AppStates {}

class NewPostState extends AppStates {}

class ProfileImagePickedSuccessState extends AppStates {}

class ProfileImagePickedErrorState extends AppStates {}

class CoverImagePickedSuccessState extends AppStates {}

class CoverImagePickedErrorState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

class UploadCoverImageSuccessState extends AppStates {}

class UploadCoverImageErrorState extends AppStates {}

class UserUpdateLoadingState extends AppStates {}

class UserUpdateErrorState extends AppStates {}
