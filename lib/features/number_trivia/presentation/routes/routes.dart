import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:test/features/number_trivia/presentation/pages/authentication/auth_page.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/home.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/onboarding/onboarding_screen.dart';

import '../pages/screens/detail_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  // '/': (context) => AuthPage(),
  '/': (context) => OnboardingScreen(),
  '/first': (context) => Home()
};
