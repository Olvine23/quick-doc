import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome to Quick Doc",
          style: kHeadStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Let us help you find a doc in no time 😃",
          style: TextStyle(
              color: Color(CustomColors.grey02), fontWeight: FontWeight.w900),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
              height: 500,
              child: Lottie.asset('assets/doc_two.json', repeat: false)

              // Lottie.network(
              //     'https://assets7.lottiefiles.com/packages/lf20_zpjfsp1e.json',
              //     repeat: false)

              ),
        ),
      ],
    );
  }
}
