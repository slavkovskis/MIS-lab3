import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab2_213094/provider/auth_provider.dart';
import 'package:lab2_213094/provider/favorite_joke_provider.dart';
import 'package:lab2_213094/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  String? token = await messaging.getToken();
  print("FCM Registration Token: $token");

  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(const MyApp());
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("Handling background message: ${message.notification?.title}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoriteJokeProvider()),
          ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '213094-Jokes',
          home: LoginScreen(),
          // home: Home(),
        ),
      );
}
