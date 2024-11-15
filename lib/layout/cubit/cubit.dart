import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/models/message_model.dart';
import 'package:noook/models/post_model.dart';
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
    if (index == 1) {
      getAllUsers();
    }
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

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(File(profileImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
        debugPrint(value);
        updateProfile(
          name: name,
          phone: phone,
          bio: bio,
          profileImage: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
      debugPrint(error.toString());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(File(coverImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadCoverImageSuccessState());
        debugPrint(value);
        updateProfile(
          name: name,
          phone: phone,
          bio: bio,
          coverImage: value,
        );
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
      debugPrint(error.toString());
    });
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

  XFile? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = XFile(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(File(postImage!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        debugPrint(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(CreatePostErrorState());
        debugPrint(error.toString());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
      debugPrint(error.toString());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<String> commentText = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {});

        element.reference
            .collection('comments')
            .doc(userModel!.uId)
            .get()
            .then((value) {
          if (value.exists) {
            var comment = value.get('comment');
            commentText.add(comment);
            debugPrint(comment);
          } else {
            commentText.add("");
            debugPrint("no comment");
          }
        });

        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(
            PostModel.fromJson(
              element.data(),
            ),
          );
        }).catchError((error) {});
      }
      emit(GetPostSuccessState());
    }).catchError((error) {
      emit(GetPostErrorState(error));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  void comment(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': comment}).then((value) {
      emit(CommentSuccessState());
    }).catchError((error) {
      emit(CommentErrorState());
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        emit(GetAllUsersErrorState(error));
      });
    }
  }

  void sendMessage(
    String receiverId,
    String dateTime,
    String msg,
  ) {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      msg: msg,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(
          MessageModel.fromJson(element.data()),
        );
      }
    });

    emit(GetMessagesSuccessState());
  }
}
