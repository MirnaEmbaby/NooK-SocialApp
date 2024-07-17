import 'package:flutter/material.dart';
import 'package:noook/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: defaultAppBar(
          context: context,
          title: 'Add Post',
        ),
      ),
    );
  }
}
