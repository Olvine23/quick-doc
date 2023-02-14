import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const ImageTile({super.key, required this.imagePath,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey[200],
            border: Border.all(color: Colors.white)),
        child: Image.asset(
          imagePath,
          height: 6.h,
        ),
      ),
    );
  }
}
