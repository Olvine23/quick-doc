import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/authentication/auth_page.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/onboarding/intro-screens/screen_two.dart';

import 'intro-screens/screen_one.dart';
import 'intro-screens/screen_three.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
            controller: _controller,
            children: [ScreenOne(), ScreenTwo(), ScreenThree()]),
        Container(
            alignment: Alignment(0, 0.75),
            child: SmoothPageIndicator(
                effect: SwapEffect(dotColor: Colors.blue),
                controller: _controller,
                count: 3)),
        Container(
          alignment: Alignment(1, 0.9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      CircularProgressIndicator();
                      return AuthPage();
                    }));
                  },
                  child: Text(
                    "Skip",
                    style: kTitleStyle,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeIn);
                  },
                  child: Text(
                    "Next",
                    style: kTitleStyle,
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
