import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "QuickDoc",
            style: kHeadStyle,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "Schedule your appointments with our finest doctors. No more waiting in hospital queues. ",
              style: TextStyle(
                  color: Color(CustomColors.grey02),
                  fontWeight: FontWeight.w900),
            ),
          ),
          Container(height: 500, child: Lottie.asset('assets/doc.json')

              // Lottie.network(
              //     'https://assets7.lottiefiles.com/packages/lf20_tutvdkg0.json')

              ),
        ],
      ),
    );
  }
}
