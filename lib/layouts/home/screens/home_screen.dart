import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:firebase_practicing/layouts/home/Widgets/social_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  //Todo: Notification button
                },
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {
                  //Todo: Search button
                },
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Location'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          // ConditionalBuilder(
          //     condition: SocialCubit.get(context).userModel != null,
          //     fallback: (context) =>
          //         const Center(child: CircularProgressIndicator()),
          //     builder: (context) {
          //
          //       return Column(
          //         children: const [
          //
          //           if (!FirebaseAuth.instance.currentUser!.emailVerified)
          //             Container(
          //               height: 50,
          //               color: Colors.amber.withOpacity(.5),
          //               child: Padding(
          //                 padding:
          //                     const EdgeInsets.symmetric(horizontal: 10),
          //                 child: Row(
          //                   children: [
          //                     const Icon(Icons.info_outlined),
          //                     const SizedBox(
          //                       width: 20,
          //                     ),
          //                     const Expanded(
          //                       child: Text(
          //                         'Please verify your email',
          //                         style: TextStyle(
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     ),
          //                     defaultTextButton(
          //                         text: 'Send',
          //                         function: () {
          //                           FirebaseAuth.instance.currentUser!
          //                               .sendEmailVerification()
          //                               .then((value) {
          //                             showToast(
          //                                 message: 'Check your mail box',
          //                                 state: ToastStates.success);
          //                           }).catchError((error) {});
          //                         }),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //         ],
          //       );
          //     }),
        );
      },
    );
  }
}