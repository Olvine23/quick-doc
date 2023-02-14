import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class AuthButton extends StatelessWidget {
  final Function() onTap;
  final String authText;
  const AuthButton({super.key, required this.onTap, required this.authText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.sp),
        margin: EdgeInsets.symmetric(horizontal: 25.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.black),
        child: Text(
           authText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
