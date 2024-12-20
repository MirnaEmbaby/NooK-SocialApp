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

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {}

class PostImagePickedSuccessState extends AppStates {}

class PostImagePickedErrorState extends AppStates {}

class RemovePostImageState extends AppStates {}

class GetPostSuccessState extends AppStates {}

class GetPostLoadingState extends AppStates {}

class GetPostErrorState extends AppStates {
  final String error;

  GetPostErrorState(this.error);
}

class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {}

class CommentSuccessState extends AppStates {}

class CommentErrorState extends AppStates {}

class GetCommentSuccessState extends AppStates {}

class GetCommentErrorState extends AppStates {
  final String error;

  GetCommentErrorState(this.error);
}

class GetAllUsersSuccessState extends AppStates {}

class GetAllUsersErrorState extends AppStates {
  final String error;

  GetAllUsersErrorState(this.error);
}

class SendMessageSuccessState extends AppStates {}

class SendMessageErrorState extends AppStates {
  final String error;

  SendMessageErrorState(this.error);
}

class GetMessagesSuccessState extends AppStates {}
