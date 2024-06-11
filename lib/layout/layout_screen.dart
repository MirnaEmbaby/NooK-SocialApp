import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/shared/components/components.dart';
import 'package:noook/shared/styles/colors.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News Feed',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ConditionalBuilder(
        condition: AppCubit.get(context).model != null,
        builder: (context) {
          return Column(
            children: [
              if (!FirebaseAuth.instance.currentUser!.emailVerified)
                Container(
                  color: myIndigo.withOpacity(0.6),
                  padding: const EdgeInsets.all(10.0),
                  height: 56.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      defaultTextButton(
                        function: () {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification()
                              .then((value) {
                            showToast('Check your mail', ToastStates.success);
                          }).catchError((error) {
                            debugPrint(error.toString());
                          });
                        },
                        text: 'Click here to verify your email',
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
            ],
          );
        },
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
