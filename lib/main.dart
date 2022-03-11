import 'package:bloc/bloc.dart';
import 'package:firebase_practicing/features/login/login_screen.dart';

import 'core/cache/cache_helper.dart';
import 'core/themes/themes.dart';
import 'core/web/API/dio_helper.dart';
import 'features/login/cubit/bloc_observer.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DioHelper.init();

  await CacheHelper.init();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

  // runApp(const MyApp());
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
