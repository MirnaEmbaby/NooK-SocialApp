import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/models/post_model.dart';
import 'package:noook/modules/new_post/new_post_screen.dart';
import 'package:noook/shared/components/components.dart';
import 'package:noook/shared/styles/colors.dart';
import 'package:noook/shared/styles/icon_broken.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).userModel != null,
          builder: (context) {
            if (AppCubit.get(context).posts.isEmpty) {
              AppCubit.get(context).getPosts();
            }
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPost(
                            AppCubit.get(context).posts[index], context, index),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10.0),
                        itemCount: AppCubit.get(context).posts.length,
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FloatingActionButton(
                      elevation: 5.0,
                      onPressed: () {
                        navigateTo(
                          context,
                          NewPostScreen(),
                        );
                      },
                      backgroundColor: myIndigo,
                      child: const Icon(
                        IconBroken.Paper_Upload,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}

Widget buildPost(PostModel model, context, index) {
  var commentController = TextEditingController();
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 4.0,
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(model.image),
                radius: 25.0,
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
                                .copyWith(height: 1.4),
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
                    Text(
                      model.dateTime,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.grey, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  size: 18.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              model.text,
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 3.0,
            ),
            width: double.infinity,
            child: Wrap(
              spacing: 2.0,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 2.0,
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    '#software_development',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 2.0,
                      ),
                    ),
                    minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    '#flutter',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (model.postImage != '')
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(model.postImage),
                ),
              ),
            ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 20,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          '${AppCubit.get(context).likes[index]}',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.grey, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 100.0),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 20.0,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          '${AppCubit.get(context).comments[index]} comments',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.grey, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (AppCubit.get(context).commentText[index] != '')
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
          if (AppCubit.get(context).commentText[index] != '')
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(AppCubit.get(context).userModel!.image),
                    radius: 12.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 2.0),
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        AppCubit.get(context).commentText[index],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(AppCubit.get(context).userModel!.image),
                  radius: 16.0,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: TextFormField(
                    onFieldSubmitted: (s) => AppCubit.get(context).comment(
                      AppCubit.get(context).postsId[index],
                      commentController.text,
                    ),
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: 'write your comment...',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        AppCubit.get(context)
                            .likePost(AppCubit.get(context).postsId[index]);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5.0),
                          Text('Like',
                              style: Theme.of(context).textTheme.labelLarge),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Send,
                            size: 20,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 5.0),
                          Text('Share',
                              style: Theme.of(context).textTheme.labelLarge),
                        ],
                      ),
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
