import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/home_tab.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/doctors/doctors_screen.dart';

import '../../schedule/models/appointment.dart';
import '../../schedule/models/doctor.dart';
import '../home.dart';

class DaktariDetailsScreen extends StatefulWidget {
  final Daktari daktari;

  const DaktariDetailsScreen({super.key, required this.daktari});

  @override
  State<DaktariDetailsScreen> createState() => _DaktariDetailsScreenState();
}

class _DaktariDetailsScreenState extends State<DaktariDetailsScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.daktari.specialty),
            Text(
                'Available times for ${DateFormat('EEE, MMM d').format(selectedDate)}'),
            Wrap(
              children: widget.daktari.availableTimes
                  .map((time) => InkWell(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selectedTime == time
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('${time.format(context)} am'),
                        ),
                        onTap: () {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                      ))
                  .toList(),
            ),
            ElevatedButton(
              child: Text('Book appointment'),
              onPressed: selectedTime != null
                  ? () {
                      // Create the appointment and add it to the database
                      final appointment = Appointment(
                        doctor: widget.daktari,
                        dateTime: DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime!.hour,
                            selectedTime!.minute),
                        userId: FirebaseAuth.instance.currentUser!
                            .uid, // Replace with the user's ID
                      );

                      // Add the appointment to the database
                      FirebaseFirestore.instance
                          .collection('doctorappointment')
                          .add({
                        'daktariId': appointment.doctor.id,
                        'dateTime': Timestamp.fromDate(appointment.dateTime),
                        'userId': appointment.userId,
                        'patient': user!.displayName,
                        'doctor': appointment.doctor.firstName,
                      });

                      // Show a confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Lottie.asset('assets/success.json',
                                    repeat: false),
                                Text('Appointment booked!'),
                              ],
                            ),
                            content: Text(
                                'Your appointment with ${widget.daktari.firstName} is scheduled for ${DateFormat('EEE, MMM d, h:mm a').format(appointment.dateTime)}.'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return Home();
                                  })));

                                  // Navigator.popUntil(
                                  //     context, ModalRoute.withName('/first'));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
