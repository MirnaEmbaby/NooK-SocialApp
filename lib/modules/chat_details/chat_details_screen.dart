import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/models/message_model.dart';
import 'package:noook/models/user_model.dart';
import 'package:noook/shared/styles/colors.dart';
import 'package:noook/shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  var msgController = TextEditingController();

  ChatDetailsScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(userModel.uId);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel.name,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: AppCubit.get(context).messages.isNotEmpty,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message = AppCubit.get(context).messages[index];
                            if (AppCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return buildMyMessage(message);
                            }
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10.0,
                          ),
                          itemCount: AppCubit.get(context).messages.length,
                        ),
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: (Colors.grey[300])!, width: 1.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: msgController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here ...'),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              AppCubit.get(context).sendMessage(
                                userModel.uId,
                                DateTime.now().toString(),
                                msgController.text,
                              );
                              msgController.clear();
                            },
                            height: 50.0,
                            color: myIndigo,
                            child: const Icon(
                              IconBroken.Send,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Padding(
        padding: const EdgeInsets.only(right: 80.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Text(
              model.msg,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Padding(
        padding: const EdgeInsets.only(left: 80.0),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.indigoAccent.shade100,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Text(
              model.msg,
              style: const TextStyle(fontSize: 20.0),
              softWrap: true,
            ),
          ),
        ),
      );
}
