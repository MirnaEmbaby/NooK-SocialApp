import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/models/user_model.dart';
import 'package:noook/modules/chat_details/chat_details_screen.dart';
import 'package:noook/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(context, AppCubit.get(context).users[index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10.0,
            ),
            itemCount: AppCubit.get(context).users.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildChatItem(BuildContext context, UserModel model) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(userModel: model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(model.image),
              radius: 24.0,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          model.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(height: 1.4, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 18.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
