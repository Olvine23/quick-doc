// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/authentication/auth_service.dart';
import 'package:test/features/number_trivia/presentation/components/auth_button.dart';
import 'package:test/features/number_trivia/presentation/components/img_tile.dart';
import 'package:test/features/number_trivia/presentation/components/mytextfield.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/home_tab.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/dummy.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('appusers');
  @override
  void dispose() {
     
    super.dispose();
  }

  String formText = 'teeett';
  String password = '';
  void signIn() async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));
    if (mounted) {
      try {
        var userapp = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        if (userapp != null) {
          final user = userapp.user!;
          final userData = {
            'displayName': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL
          };
          await usersCollection.doc(user.uid).set(userData);
        }
        if (mounted) {
          Navigator.pop(context);
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
    }

    //wrong email pop up
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
              child: Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height,
                      child: Lottie.network(
                          'https://assets6.lottiefiles.com/private_files/lf30_fw6h59eu.json'),
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: NetworkImage(
                      //         'https://cdn.pixabay.com/photo/2020/08/03/09/39/medical-5459631_960_720.png'),
                      //   ),
                      // ),
                    ),
                    // Rating Box

                    // Back Button
                  ],
                ),
              ),
            ),

            // Text(
            //   "Hey Champ, we are glad you are back",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            // ),
            SizedBox(height: 1.h),
            Text("QuickDoc", style: kHeadStyle),
            SizedBox(height: 1.h),

            MyTextField(
              hintText: 'Email Address',
              controller: emailController,
              obsCureText: false,
            ),
            SizedBox(height: 2.h),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obsCureText: true,
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Color(CustomColors.primary),
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(CustomColors.primary),
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signIn();
                  }
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Dummy();
                    }));
                  },
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
                  "Dont have an account yet? ",
                  style: TextStyle(fontSize: 9.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Sign Up",
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
