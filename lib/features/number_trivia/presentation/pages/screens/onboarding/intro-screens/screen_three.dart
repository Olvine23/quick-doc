import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        Text("Docss"),
        Container(
          child: Lottie.network(
              'https://assets7.lottiefiles.com/packages/lf20_yubjrwy7/doctors.json'),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AuthPage();
              }));
            },
            child: Text("Go"))
      ],
    );
  }
}
