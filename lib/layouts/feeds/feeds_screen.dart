import 'package:firebase_practicing/core/shared/components.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 20,
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
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                              const SizedBox(width: 3),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 17,
                              ),
                            ],
                          ),
                          Text(
                            'Jun 21, 2022 at 11:00 pm',
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
                  "Lorem Ipsum is simply dummy text of the printing and "
                  "typesetting industry. Lorem Ipsum has been the industry's "
                  "standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book standard dummy.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.black, height: 1.3),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
