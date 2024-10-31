import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/shared/components/components.dart';
import 'package:noook/shared/styles/colors.dart';
import 'package:noook/shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(
                  function: () {
                    var now = DateTime.now();
                    if (AppCubit.get(context).postImage == null) {
                      AppCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    } else {
                      AppCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    }
                  },
                  text: 'Post',
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          ),
          body: Column(
            children: [
              if (state is CreatePostLoadingState)
                const LinearProgressIndicator(),
              if (state is CreatePostLoadingState)
                const SizedBox(
                  height: 10,
                ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            AppCubit.get(context).userModel!.image),
                        radius: 25.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'What are you thinking about ...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (AppCubit.get(context).postImage != null)
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Image(
                        image: FileImage(
                            File(AppCubit.get(context).postImage!.path)),
                        height: 250.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        height: 250.0,
                        width: double.infinity,
                      ),
                      IconButton(
                        onPressed: () {
                          AppCubit.get(context).removePostImage();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                        onPressed: () {
                          AppCubit.get(context).getPostImage();
                        },
                        height: 50.0,
                        color: myIndigo,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Upload,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Upload photo',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      height: 50.0,
                      color: myIndigo,
                      child: const Text(
                        '# Tags',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
