import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10.0,
          margin: EdgeInsets.all(8.0),
          child: Image(
            image: NetworkImage(
              'https://img.freepik.com/free-vector/followers-line-concept-illustration_52683-23650.jpg?t=st=1718229543~exp=1718233143~hmac=89bff9940dded3c8d12a921224139d8b7ef2446bfe8d3cb5c118530db8892651&w=2000',
            ),
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10.0,
          margin: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/young-brunette-woman-wearing-red-eyeglasses_273609-41258.jpg?t=st=1718279227~exp=1718282827~hmac=f5d5ba509a8e6d19219a2a0041782eb629a1751d5b828559f4758586f563eba0&w=1380',
                      ),
                      radius: 25.0,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Some dude',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
