import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_practicing/core/shared/constant.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:firebase_practicing/models/message%20model/message_model.dart';
import 'package:firebase_practicing/models/user%20model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/Widgets/social_cubit.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen(this.userModel, {Key? key}) : super(key: key);
  UserModel userModel;
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state)
      {
        SocialCubit.get(context).getMessages(receiverId: userModel.uid!);
        return Builder(
          builder:  (context)
          {
            SocialCubit.get(context).getMessages(receiverId: userModel.uid!);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    const SizedBox(width: 15),
                    Text(userModel.name!),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: MESSAGES.isNotEmpty ,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message =
                            MESSAGES[index];
                            if (SocialCubit.get(context).userModel!.uid ==
                                message.senderId) {
                              return buildMyMessage(context, message);
                            }
                            return buildMessage(context , message);
                          },
                          separatorBuilder: (context, index) =>
                          const SizedBox(
                            height: 15,
                          ),
                          itemCount: MESSAGES.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      hintText: 'Message here')),
                            ),
                            //---------send Message button----
                            MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel.uid,
                                  dateTime: DateTime.now().toString(),
                                  message: messageController.text,
                                );
                                messageController.text = '';
                              },
                              minWidth: 1,
                              child: const Icon(
                                Icons.send,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: userModel.uid,
                                  dateTime: DateTime.now().toString(),
                                  message: messageController.text,
                                );
                                messageController.text = '';
                              },
                              minWidth: 1,
                              child: const Icon(
                                Icons.image,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
              ),
            );
          },

        );
      },
    );

  }

  Widget buildMessage(context, MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(model.message!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 15)),
        ),
      );

  Widget buildMyMessage(context, MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            model.message!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 15),
          ),
        ),
      );
}
