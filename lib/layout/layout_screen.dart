import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/shared/styles/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          // EMAIL VERIFICATION
          // ConditionalBuilder(
          //   condition: AppCubit.get(context).model != null,
          //   builder: (context) {
          //     return Column(
          //       children: [
          //         if (!FirebaseAuth.instance.currentUser!.emailVerified)
          //           Container(
          //             color: myIndigo.withOpacity(0.6),
          //             padding: const EdgeInsets.all(10.0),
          //             height: 56.0,
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 const Icon(
          //                   Icons.info_outline,
          //                   color: Colors.white,
          //                 ),
          //                 defaultTextButton(
          //                   function: () {
          //                     FirebaseAuth.instance.currentUser!
          //                         .sendEmailVerification()
          //                         .then((value) {
          //                       showToast('Check your mail', ToastStates.success);
          //                     }).catchError((error) {
          //                       debugPrint(error.toString());
          //                     });
          //                   },
          //                   text: 'Click here to verify your email',
          //                   color: Colors.white,
          //                 )
          //               ],
          //             ),
          //           ),
          //       ],
          //     );
          //   },
          //   fallback: (context) => const Center(child: CircularProgressIndicator()),
          // ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Profile),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
