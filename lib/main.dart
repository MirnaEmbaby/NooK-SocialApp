import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noook/layout/cubit/cubit.dart';
import 'package:noook/layout/cubit/states.dart';
import 'package:noook/layout/layout_screen.dart';
import 'package:noook/modules/login/login_screen.dart';
import 'package:noook/shared/bloc_observer.dart';
import 'package:noook/shared/components/components.dart';
import 'package:noook/shared/network/local/cache_helper.dart';
import 'package:noook/shared/styles/themes.dart';

import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Message data: ${message.data}');
  showToast('background notification', ToastStates.success);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  debugPrint(await messaging.getToken());

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const LayoutScreen();
  } else {
    widget = LoginScreen();
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Message data: ${message.data}');
    showToast('on message notification', ToastStates.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('Message data: ${message.data}');
    showToast('on message opened app notification', ToastStates.success);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getPosts(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
