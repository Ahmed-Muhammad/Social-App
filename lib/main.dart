import 'package:bloc/bloc.dart';
import 'package:firebase_practicing/features/login/screens/login_screen.dart';

import 'core/bloc_observer/bloc_observer.dart';
import 'core/cache/cache_helper.dart';
import 'core/themes/themes.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await CacheHelper.init();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LoginScreen(),
    );
  }
}
