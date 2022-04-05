import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_practicing/core/shared/components.dart';
import 'package:firebase_practicing/core/shared/constant.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:firebase_practicing/models/post%20model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/Widgets/social_cubit.dart';
import 'comment_page.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen( {Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state)
      {
        if ( state is SocialGetPostsLoadingState ) {
          SocialCubit.get(context).getPosts();
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        print('length in feeds   ${POSTS.length}');
        return ConditionalBuilder(
          condition: POSTS.isNotEmpty ,
          builder: (context) => RefreshIndicator(
            onRefresh: cubit.refresh,
            displacement: 100,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      const Image(
                        image: NetworkImage(
                          'https://img.freepik'
                          '.com/free-vector/pop-art-girl-pointing-something_1441-108.jpg?t=st=1647592427~exp=1647593027~hmac=1581e36c8ed28aee564255387d82185ec93feafb83d3470de036f5da4b812d2b&w=996',
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: POSTS.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildPostItem(context, POSTS[index], index);
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ]),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(
      BuildContext context, CreatePostModel model, index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(model.image!),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: 16,
                                    color: Colors.black,
                                    height: 1.3),
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 17,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime!,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(height: 1.3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.blue,
                      size: 20,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text!,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black, height: 1.2),
            ),
            const SizedBox(height: 10),
            // const SizedBox(
            //   width: double.infinity,
            //   // child: Wrap(
            //   //   children: const [
            //   //     // Padding(
            //   //     //   padding: const EdgeInsetsDirectional.only(end: 5),
            //   //     //   child: SizedBox(
            //   //     //     height: 20,
            //   //     //     child: MaterialButton(
            //   //     //       minWidth: 1,
            //   //     //       padding: EdgeInsets.zero,
            //   //     //       onPressed: () {},
            //   //     //       child: Text(
            //   //     //         '#Software_developments',
            //   //     //         style: Theme.of(context)
            //   //     //             .textTheme
            //   //     //             .caption
            //   //     //             ?.copyWith(color: Colors.blue, fontSize: 14),
            //   //     //       ),
            //   //     //     ),
            //   //     //   ),
            //   //     // ),
            //   //     // Padding(
            //   //     //   padding: const EdgeInsetsDirectional.only(end: 5),
            //   //     //   child: SizedBox(
            //   //     //     height: 20,
            //   //     //     child: MaterialButton(
            //   //     //       minWidth: 1,
            //   //     //       padding: EdgeInsets.zero,
            //   //     //       onPressed: () {},
            //   //     //       child: Text(
            //   //     //         '#Mobile_developments',
            //   //     //         style: Theme.of(context)
            //   //     //             .textTheme
            //   //     //             .caption
            //   //     //             ?.copyWith(color: Colors.blue, fontSize: 14),
            //   //     //       ),
            //   //     //     ),
            //   //     //   ),
            //   //     // ),
            //   //     // Padding(
            //   //     //   padding: const EdgeInsetsDirectional.only(end: 5),
            //   //     //   child: SizedBox(
            //   //     //     height: 20,
            //   //     //     child: MaterialButton(
            //   //     //       minWidth: 1,
            //   //     //       padding: EdgeInsets.zero,
            //   //     //       onPressed: () {},
            //   //     //       child: Text(
            //   //     //         '#Flutter_developments',
            //   //     //         style: Theme.of(context)
            //   //     //             .textTheme
            //   //     //             .caption
            //   //     //             ?.copyWith(color: Colors.blue, fontSize: 14),
            //   //     //       ),
            //   //     //     ),
            //   //     //   ),
            //   //     // ),
            //   //     // Padding(
            //   //     //   padding: const EdgeInsetsDirectional.only(end: 5),
            //   //     //   child: SizedBox(
            //   //     //     height: 20,
            //   //     //     child: MaterialButton(
            //   //     //       minWidth: 1,
            //   //     //       padding: EdgeInsets.zero,
            //   //     //       onPressed: () {},
            //   //     //       child: Text(
            //   //     //         '#Flutter_developments',
            //   //     //         style: Theme.of(context)
            //   //     //             .textTheme
            //   //     //             .caption
            //   //     //             ?.copyWith(color: Colors.blue, fontSize: 14),
            //   //     //       ),
            //   //     //     ),
            //   //     //   ),
            //   //     // ),
            //   //   ],
            //   // ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        model.postImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '0 comments',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context,  CommentScreen());
                    },
                    child: Row(children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            SocialCubit.get(context).userModel!.image!),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Write a comment ...',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(height: 1.3),
                      )
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 20,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
