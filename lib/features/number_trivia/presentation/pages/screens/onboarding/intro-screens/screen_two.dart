import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Screen 2"),
        Container(
            height: 400,
            child: Lottie.network(
                'https://assets7.lottiefiles.com/private_files/lf30_tul1qoqd.json')),
      ],
    );
  }
}
