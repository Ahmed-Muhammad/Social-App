import 'package:firebase_practicing/features/login/screens/login_screen.dart';

// ignore: unused_import
import 'package:firebase_practicing/features/verify_email/screen/verify_phone_screen.dart';
import 'package:firebase_practicing/layouts/home/Widgets/social_cubit.dart';
import 'package:firebase_practicing/layouts/home/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc_observer/bloc_observer.dart';
import 'core/cache/cache_helper.dart';
import 'core/shared/constant.dart';
import 'core/themes/themes.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //ensure every thing is Initialized then Run App
  WidgetsFlutterBinding.ensureInitialized();
  //---------- shared Preferences Initialization ------------
  await CacheHelper.init();
  //---------- Firebase Initialization ------------
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget? selectedScreen;
//uid is saved in constant
  uid = CacheHelper.getData(key: 'uid');
  print("uid in main => $uid )");

  if (uid != null) {
    selectedScreen = const HomeScreen();
  } else {
    selectedScreen = const LoginScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        selectedScreen: selectedScreen,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.selectedScreen}) : super(key: key);
  final Widget? selectedScreen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: selectedScreen,
      ),
    );
  }
}
