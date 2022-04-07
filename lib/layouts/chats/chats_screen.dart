import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_practicing/core/shared/components.dart';
import 'package:firebase_practicing/models/user%20model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/Widgets/social_cubit.dart';
import 'chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(context, SocialCubit.get(context).users[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context, UserModel model) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          ChatDetailsScreen(model),
        );
      },
      child: Padding(
        //vcbbcvb
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(model.image!),
            ),
            const SizedBox(width: 15),
            Text(
              model.name!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontSize: 16, color: Colors.black, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
