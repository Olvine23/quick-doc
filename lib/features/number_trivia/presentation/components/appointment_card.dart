import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:test/features/number_trivia/presentation/components/clock_icon.dart';
import 'package:test/features/number_trivia/presentation/components/custom_profile.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 22.h,
      width: size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Appointment date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomIcon(icon: Icons.calendar_today),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Wed"),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Jun"),
                              SizedBox(
                                width: 5,
                              ),
                              Text("21"),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomIcon(
                                icon:Icons.watch_later_sharp,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("8:00 - 9:00am")
                            ],
                          ),
                          Icon(Icons.more_vert_sharp)
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListTile(
                        leading: Custom_profile(),
                        title: Text("Doctor Bob ",
                            style: TextStyle(fontWeight: FontWeight.w900)),
                        subtitle: Text(
                          "Pschologist",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
