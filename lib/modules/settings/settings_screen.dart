import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = AppCubit.get(context).model;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 180.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/front-view-horizontal-white-copy-space-wall_23-2148801259.jpg?t=st=1718396105~exp=1718399705~hmac=892964f1c737d94808873e23d63ef25dd7d09ef04b01166a32567c608a2f1aa5&w=2000',
                        ),
                        height: 140.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CircleAvatar(
                      radius: 70.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-happy-smiley-man_23-2149022624.jpg?t=st=1718395807~exp=1718399407~hmac=db2c6c0b97c418d50b203832cfd4810cadd0ee941bdc5d879368e1dba2444ad3&w=2000',
                        ),
                        radius: 65.0,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Anonymous Person',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 22.0),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'Bio ... ',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.grey[600]),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: defaultButton(
                      function: () {},
                      text: 'Edit profile',
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
