import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Welcome to Quick Doc"),
        Container(
            height: 500,
            child: Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_zpjfsp1e.json',
                repeat: false)),
      ],
    );
  }
}
