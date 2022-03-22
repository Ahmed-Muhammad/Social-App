import 'package:firebase_practicing/core/shared/components.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/Widgets/social_cubit.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppbar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(text: 'POST', function: () {}),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://scontent.fcai21-2.fna.fbcdn.net/v/t1.6435-9/36137473_1672721836179430_3456862169725927424_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=9tYeesdPuIQAX_nct-b&tn=vOLAikUZ_sGc5L8h&_nc_ht=scontent.fcai21-2.fna&oh=00_AT8Oo-xDechHRInJ_IBubDRLxcFftLHFysjrw5LF-iGpKg&oe=625A1564'),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Ahmad M. Hassanien',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: 16,
                                    color: Colors.black,
                                    height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 50,
                    decoration: const InputDecoration(
                      hintText: "What's in your mind?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Add Photos',
                              style:
                                  TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '#Tags',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
