import 'package:firebase_practicing/core/shared/components.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/Widgets/social_cubit.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = cubit.userModel;
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;

        return Scaffold(
          appBar: defaultAppbar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(text: 'Update'.toUpperCase(), function: () {}),
              const SizedBox(width: 10)
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //------------cover & profile picture edit---------------
                  SizedBox(
                    height: 350,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              //--------cover picture-----------
                              Container(
                                height: 250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                    coverImage == null
                                      ? NetworkImage(userModel!.cover!)
                                        : FileImage(coverImage) as
                                      ImageProvider,
                                  ),
                                ),
                              ),
                              //--------cover picture edit button-----------
                              IconButton(
                                splashRadius: 1,
                                icon: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey.withOpacity(.5),
                                  child: const Icon(
                                    IconBroken.Camera,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                                onPressed: ()
                                {
                                  cubit.getCoverImage() ;
                                },
                              ),
                            ],
                          ),
                        ),
                        //--------profile picture----------------
                        CircleAvatar(
                          //حدود الصوره الداخليه البيضاء
                          radius: 105,
                          //لون الحدود الابيض
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: 
                                profileImage == null 
                                ? NetworkImage(userModel!.image!)
                                : FileImage(profileImage) as ImageProvider,
                                
                                radius: 100,
                              ),
                              //--------profile picture edit button-----------
                              IconButton(
                                splashRadius: 1,
                                icon: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey.withOpacity(.5),
                                  child: const Icon(
                                    IconBroken.Camera,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                                onPressed: ()
                                {
                                  cubit.getProfileImage();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //------------Name & Bio edit---------------
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: defaultFormField(
                      hint: userModel!.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Update your name';
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      controller: nameController,
                      label: 'Name',
                      prefix: IconBroken.User1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: defaultFormField(
                      maxLength: 20,
                      hint: userModel.bio,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Update your bio';
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      controller: nameController,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
