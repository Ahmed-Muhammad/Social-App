import 'package:firebase_practicing/core/shared/components.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/Widgets/social_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              //------------cover & profile picture----------------
              SizedBox(
                height: 350,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    //--------cover picture-----------
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage
                            (userModel!.cover!)),
                        ),
                      ),
                    ),
                    //--------profile picture------
                    CircleAvatar(
                      //حدود الصوره الداخليه البيضاء
                      radius: 105,
                      //لون الحدود الابيض
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          userModel.image!,
                        ),
                        radius: 100,
                      ),
                    ),
                  ],
                ),
              ),
              //-------------profile Name--------------------------
              const SizedBox(
                height: 5,
              ),
              Text(
                userModel.name!,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 25,
                    ),
              ),
              //-------------profile Bio--------------------------
              Text(
                userModel.bio!,
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              //-----------Number of Posts & friends $ followers---------
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '880',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              'posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '271',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '892',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '62',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-----------Edit Buttons ------------------
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left : 10 , right: 10),
                      child: OutlinedButton(
                        child:  const Text('Add photos'),
                        onPressed: (){},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( right: 10),
                    child: OutlinedButton(

                      child: const Icon(IconBroken.Edit , size: 16,),
                      onPressed: (){},
                    ),
                  ),


                ],
              ),

            ],
          ),
        );
      },
    );
  }
}
