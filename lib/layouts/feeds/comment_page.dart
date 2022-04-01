import 'package:comment_tree/comment_tree.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:firebase_practicing/layouts/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/Widgets/social_cubit.dart';

// ignore: must_be_immutable
class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key}) : super(key: key);

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Dismissible(
            background: const HomeScreen(),
            key: const Key('key'),
            direction: DismissDirection.vertical,
            onDismissed: (_) => Navigator.of(context).pop(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Be first to like this',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                titleSpacing: -45,
                leading: const Offstage(),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(IconBroken.Heart),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    //--------------written comment ----------------
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) =>
                          buildWrittenComment(context, index),
                    ),
                  ),
                  //-------write comment section-------------
                  buildCommentSection(context),
                ],
              ),
            ),
          );
        });
  }

  Widget buildWrittenComment(context, index) {
    return Column(
      children: [
        Container(
          child: CommentTreeWidget<Comment, Comment>(
            //--------------comment---------------------------
            Comment(
                avatar: 'null',
                userName: 'null',
                content: 'Never know the'
                    ' doer, for you cannot discover it. doer, for you cannot '
                    'discover it. doer, for you cannot discover it. '),
            const [],
            treeThemeData: const TreeThemeData(
              lineColor: Colors.white,
            ),
            avatarRoot: (context, data) => const PreferredSize(
              //------------------------Image---------------------------
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                    'https://scontent.fcai21-2.fna.fbcdn.net/v/t1.6435-9/36137473_1672721836179430_3456862169725927424_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=9tYeesdPuIQAX_nct-b&tn=vOLAikUZ_sGc5L8h&_nc_ht=scontent.fcai21-2.fna&oh=00_AT8Oo-xDechHRInJ_IBubDRLxcFftLHFysjrw5LF-iGpKg&oe=625A1564'),
              ),
              preferredSize: Size.fromRadius(18),
            ),

            contentRoot: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //-------------------Name--------------------------
                        Text(
                          'Ahmad M. Hassanien',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                        ),
                        Text(
                          '${data.content}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  height: 1.2,
                                  wordSpacing: .1),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ],
    );
  }

  Widget buildCommentSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Divider(
          color: Colors.grey,
          thickness: 1,
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            minLines: 1,
            maxLines: 4,
            controller: commentController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Write a comment... ',
              contentPadding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5, bottom: 5),
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: InkWell(
            onTap: () {
              //here to use the postComment function and I need the index here

            },
            child: const Icon(
              Icons.send,
            ),
          ),
        ),
      ],
    );
  }

// Widget buildCommentSection(context, index) {
//   return Container(
//     // decoration: const BoxDecoration(
//     //   image: DecorationImage(
//     //     image: NetworkImage(
//     //       'https://i.ibb.co/zGZyH0w/asd.jpg',
//     //     ),
//     //   ),
//     // ),
//     child: Align(
//       alignment: Alignment.topLeft,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 65.0,
//             ),
//             child: Text(
//               'Ahmad M. Hassanien',
//               style: Theme.of(context).textTheme.bodyText1?.copyWith(
//                   fontSize: 15, color: Colors.black, height: 1.3),
//             ),
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                   padding:
//                       EdgeInsets.only(left: 10.0, top: 0, bottom: 10.0),
//                   child: CircleAvatar(
//                     radius: 20,
//                     backgroundImage: NetworkImage(
//                         'https://scontent.fcai21-2.fna.fbcdn.net/v/t1.6435-9/36137473_1672721836179430_3456862169725927424_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=9tYeesdPuIQAX_nct-b&tn=vOLAikUZ_sGc5L8h&_nc_ht=scontent.fcai21-2.fna&oh=00_AT8Oo-xDechHRInJ_IBubDRLxcFftLHFysjrw5LF-iGpKg&oe=625A1564'),
//                   )),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 10, right: 15, top: 0, bottom: 10),
//                   child: TextFormField(
//                     readOnly: true,
//                     minLines: 1,
//                     maxLines: 50,
//                     controller: commentController,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       hintText: commentController.text,
//                       contentPadding: const EdgeInsets.only(
//                           left: 15.0, right: 15.0, top: 5, bottom: 5),
//                       hintStyle: const TextStyle(color: Colors.black),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

}
