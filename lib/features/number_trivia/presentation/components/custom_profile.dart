import 'package:flutter/material.dart';

class Custom_profile extends StatelessWidget {
  const Custom_profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/doctor.png'))),
      // child: Image.asset(img_path),
    );
  }
}
