import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/models/user_model.dart';
import 'package:noook/modules/chats/chats_screen.dart';
import 'package:noook/modules/feed/feed_screen.dart';
import 'package:noook/modules/profile/profile_screen.dart';
import 'package:noook/modules/users/users_screen.dart';
import 'package:noook/shared/components/components.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      debugPrint(value.data().toString());

      userModel = UserModel.fromJson(value.data()!);

      emit(GetUserSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Profile',
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  XFile? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = XFile(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  XFile? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = XFile(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(File(profileImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
        debugPrint(value);
        profileImageUrl = value;
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
      debugPrint(error.toString());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(File(coverImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadCoverImageSuccessState());
        debugPrint(value);
        coverImageUrl = value;
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
      debugPrint(error.toString());
    });
  }

  void updateProfileImages({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null && profileImage != null) {
    } else {
      updateProfile(
        name: name,
        phone: phone,
        bio: bio,
      );
    }
  }

  void updateProfile({
    required String name,
    required String phone,
    required String bio,
    String? profileImage,
    String? coverImage,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: profileImage ?? userModel!.image,
      cover: coverImage ?? userModel!.cover,
      email: userModel!.email,
      uId: userModel!.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UserUpdateErrorState());
    });
  }
}
