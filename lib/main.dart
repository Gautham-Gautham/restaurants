import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_grandmerche/splash_screen.dart';

import 'firebase_options.dart';

// ignore: prefer_typing_uninitialized_variables
var width;
// ignore: prefer_typing_uninitialized_variables
var height;
bool loggedIn = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const MaterialApp(
        title: 'The Grand Marche',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
