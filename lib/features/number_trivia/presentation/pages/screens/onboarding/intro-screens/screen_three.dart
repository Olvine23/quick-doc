import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/styles.dart';

import '../../../authentication/auth_page.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Docss",
          style: kHeadStyle,
        ),
        Container(
          child: Lottie.asset('assets/fifth.json', repeat: false),
          // child: Lottie.network(
          //     'https://assets7.lottiefiles.com/packages/lf20_yubjrwy7/doctors.json'),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AuthPage();
              }));
            },
            child: Text("Let's Go 🚀"))
      ],
    );
  }
}
