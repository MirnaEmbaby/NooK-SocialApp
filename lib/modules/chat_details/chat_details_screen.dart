import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
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
                buildMessage(),
                const SizedBox(
                  height: 12.0,
                ),
                buildMyMessage(),
                const Spacer(),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(color: (Colors.grey[300])!, width: 1.0),
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
  }

  Widget buildMessage() => Padding(
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
            child: const Text(
              'msg1 msg1 msg1 msg1 msg1 msg1 msg1 msg1 msg1 msg1 msg1 msg1',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      );

  Widget buildMyMessage() => Padding(
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
            child: const Text(
              'msg2 msg2 msg2 msg2 msg2 msg2 msg2 msg2 msg2 msg2 msg2 msg2',
              style: TextStyle(fontSize: 20.0),
              softWrap: true,
            ),
          ),
        ),
      );
}
