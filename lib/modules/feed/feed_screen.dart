import 'package:flutter/material.dart';
import 'package:noook/shared/styles/icon_broken.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Card(
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
            margin: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/young-brunette-woman-wearing-red-eyeglasses_273609-41258.jpg?t=st=1718279227~exp=1718282827~hmac=f5d5ba509a8e6d19219a2a0041782eb629a1751d5b828559f4758586f563eba0&w=1380',
                        ),
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
                                Text(
                                  'Some dude',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(height: 1.4),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 18.0,
                                ),
                              ],
                            ),
                            Text(
                              'January 21, 2021 at 11:00 pm',
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
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
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
                            minimumSize:
                                WidgetStateProperty.all(const Size(0, 0)),
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
                            minimumSize:
                                WidgetStateProperty.all(const Size(0, 0)),
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
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/image-hesitant-unshaven-european-man-with-thick-beard-holds-chin-purses-lips-with-clueless-expressions_273609-17361.jpg?t=st=1718316822~exp=1718320422~hmac=5db7451397018bf206c5a55460f7fdb0bfacfb6770f9db65cee225cf640ca0db&w=2000',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 20,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '120',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.grey, height: 1.4),
                      ),
                      const Spacer(),
                      const Icon(
                        IconBroken.Chat,
                        color: Colors.yellow,
                        size: 20.0,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '80',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.grey, height: 1.4),
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'comments',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.grey, height: 1.4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
