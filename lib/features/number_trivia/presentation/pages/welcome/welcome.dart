// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:test/features/number_trivia/presentation/components/head.dart';
import 'package:test/features/number_trivia/presentation/dummy/mock_docs.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/schedule_calendar.dart';
import 'package:test/features/number_trivia/presentation/components/appointment_card.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});

  List docs = [
    ['Jane Mark', 'assets/images/female_doc.png', 'Kakamega'],
    ['Jane Doe', 'assets/images/female_doc.png', 'Kisumu'],
    ['Jane Kaimu', 'assets/images/doctor.png', 'Nairobi'],
    ['Kiare Mark', 'assets/images/black_doc.png', 'Malindi'],
  ];

  final user = FirebaseAuth.instance.currentUser;

  void sign_out() async {
    AlertDialog(
      content: Text("Sign out"),
    );
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.grey,
            iconSize: 25,
            padding: EdgeInsets.all(18.0),
            gap: 5,
            tabs: const [
              GButton(text: "Home", icon: Icons.home),
              GButton(
                text: "Add",
                icon: Icons.add_alert,
                iconSize: 40,
              ),
              GButton(text: "Search", icon: Icons.search),
              GButton(text: "Settings", icon: Icons.settings),
            ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return ScheduleCalendar();
              })));
            },
            child: Icon(
              Icons.add_alarm,
            )),
        // appBar: AppBar(actions: [
        //   IconButton(onPressed: sign_out, icon: Icon(Icons.logout))
        // ], title: Text("User Screen")),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Head(user: user),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.sp),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "QuickDoc Services",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      height: 140,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: docs.length,
                          itemBuilder: ((context, index) {
                            return DummyDocs(
                                name: docs[index][0],
                                img_path: docs[index][1],
                                company: docs[index][2]);
                          })),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming Appointments",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 12.sp),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(
                              color: Colors.blue[500],
                              fontWeight: FontWeight.w900,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 9,
                  itemBuilder: ((context, index) {
                    return AppointmentCard();
                  }))
            ],
          ),
        ));
  }
}
