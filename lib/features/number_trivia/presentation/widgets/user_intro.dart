import 'package:flutter/material.dart';

import '../components/tabs/home_tab.dart';

class UserIntro extends StatelessWidget {
  const UserIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(user!.photoURL);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '${user!.displayName} 👋',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        // CircleAvatar(
        //   backgroundImage: NetworkImage(user!.photoURL!),
        // )
        // ignore: prefer_const_constructors
        // CircleAvatar(
        //   backgroundImage: NetworkImage(
        //       'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
        // )
      ],
    );
  }
}
