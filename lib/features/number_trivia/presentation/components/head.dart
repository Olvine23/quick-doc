import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:sizer/sizer.dart';

class Head extends StatelessWidget {
  const Head({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.sp),
      height: 45.h,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Color.fromARGB(255, 142, 197, 211)])),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePicture(
                  img: '${user?.photoURL}',
                  name: '${user?.displayName}',
                  radius: 9.w,
                  fontsize: 12.sp),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.notifications_none_outlined)))),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Welcome",
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 25.sp),
                  ),
                  Text(
                    "${user?.displayName} !",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 17.sp),
                  ),
                  Text("How's your day going?"),
                  SizedBox(height: 2.h),
                  ElevatedButton.icon(
                    onPressed: (() {}),
                    label: Text("Urgent Care"),
                    icon: Icon(Icons.remove_red_eye),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 12.sp)),
                  )
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: 25.h,
                  width: 200.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/vid.png'),
                          fit: BoxFit.cover)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
