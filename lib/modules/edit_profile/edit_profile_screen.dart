import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/shared/components/components.dart';
import 'package:noook/shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  function: () {
                    AppCubit.get(context).updateProfile(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                    Navigator.pop(context);
                  },
                  text: 'Update',
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image(
                                image: coverImage == null
                                    ? NetworkImage(userModel.cover)
                                        as ImageProvider
                                    : FileImage(File(coverImage.path)),
                                height: 140.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                color: Colors.black.withOpacity(0.3),
                                height: 140.0,
                                width: double.infinity,
                              ),
                              IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .getCoverImage()
                                      .then((value) {
                                    AppCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  });
                                },
                                icon: const Icon(
                                  IconBroken.Edit,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: profileImage == null
                                          ? NetworkImage(userModel.image)
                                              as ImageProvider
                                          : FileImage(File(profileImage.path)),
                                      radius: 55.0,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.black.withOpacity(0.3),
                                      radius: 55.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              padding: const EdgeInsets.all(40.0),
                              onPressed: () {
                                AppCubit.get(context)
                                    .getProfileImage()
                                    .then((value) {
                                  AppCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                });
                              },
                              icon: const Icon(
                                IconBroken.Camera,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name cannot be empty';
                            }
                          },
                          label: 'Name',
                          prefix: IconBroken.Profile,
                          hasSuffix: false,
                        )!,
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: bioController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'bio cannot be empty';
                            }
                          },
                          label: 'Bio',
                          prefix: IconBroken.Info_Circle,
                          hasSuffix: false,
                        )!,
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone number cannot be empty';
                            }
                          },
                          label: 'Phone',
                          prefix: IconBroken.Call,
                          hasSuffix: false,
                        )!,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
