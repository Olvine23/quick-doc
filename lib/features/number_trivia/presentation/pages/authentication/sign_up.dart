// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/features/authentication/auth_service.dart';
import 'package:test/features/number_trivia/presentation/components/auth_button.dart';
import 'package:test/features/number_trivia/presentation/components/img_tile.dart';
import 'package:test/features/number_trivia/presentation/components/mytextfield.dart';
import 'package:sizer/sizer.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/dummy.dart';
 

class Register extends StatefulWidget {
  final Function()? onTap;
  Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  String formText = 'teeett';
  String password = '';

  void signIn() async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));
    try {
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        User? user = userCredential.user;
        if (user != null) {
          // ignore: deprecated_member_use
          await user.updateProfile(displayName: nameController.text);
        }
        if(mounted) {
          showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Hurray"),
          );
        });
        }

        Navigator.pop(context);
      } else {
        showErrorMessage("Passwords Dont Match");
      }
    } on FirebaseAuthException catch (e) {
      //wrong email
      if (e.code == "user-not-found") {
        Navigator.pop(context);
        //show error to the user
        wrongEmail();
        print('No user found for that email.');
      }
      //wrong password

      else if (e.code == "wrong-password") {
        Navigator.pop(context);
        // show error to the user
        wrongPassword();
        print("Wrong password");
      }
    }

    //wrong email pop up
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  void wrongEmail() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Text("Wrong email address"),
              ],
            ),
          );
        }));
  }

  void wrongPassword() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text("Wrong password"),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              // 40% of our total height
              height: size.height * 0.4,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.height,
                    child: Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_kdCeeh2u4M.json',
                      repeat: false,
                    ),

                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: NetworkImage(
                    //         'https://cdn.pixabay.com/photo/2020/08/03/09/39/medical-5459630__340.png'),
                    //   ),
                    // ),
                  ),
                  // Rating Box

                  // Back Button
                ],
              ),
            ),
            MyTextField(
              controller: nameController,
              hintText: 'Enter name',
              obsCureText: false,
            ),
            SizedBox(height: 1.h),
            MyTextField(
              hintText: 'Email Address',
              controller: emailController,
              obsCureText: false,
            ),
            SizedBox(height: 1.h),
            MyTextField(
              hintText: 'Enter Desired Password',
              controller: passwordController,
              obsCureText: true,
            ),
            SizedBox(height: 1.h),
            MyTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obsCureText: true,
            ),
            SizedBox(height: 1.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(CustomColors.primary),
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: signIn,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            // AuthButton(
            //   onTap: signIn,
            //   authText: 'Sign Up',
            // ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[500],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.w),
                    child: Text("Or Continue with"),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageTile(
                  imagePath: "assets/images/google.png",
                  onTap: () => AuthService().googleAuth(),
                ),
                SizedBox(
                  width: 10.w,
                ),
                ImageTile(
                  imagePath: "assets/images/mic.png",
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 9.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
