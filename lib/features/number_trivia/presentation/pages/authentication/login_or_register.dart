import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/features/number_trivia/presentation/pages/authentication/sign_in.dart';
import 'package:test/features/number_trivia/presentation/pages/authentication/sign_up.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //show login page at first

  bool showLoginPage = true;

  //toggle between login and register

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(onTap:togglePages,);
    } else {
      return Register(onTap: togglePages,);
    }
    
  }
}
