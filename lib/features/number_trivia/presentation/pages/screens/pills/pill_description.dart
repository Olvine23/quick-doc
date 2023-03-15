import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/home_tab.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/appointment.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/drug_schedule.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/home.dart';

import '../../schedule/models/doctor.dart';

class PillDescription extends StatefulWidget {
  const PillDescription({
    super.key,
  });

  @override
  _PillDescriptionState createState() => _PillDescriptionState();
}

class _PillDescriptionState extends State<PillDescription> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedDoctor;
  String? _selectedReason;
  String? _selectedLocation;
  final _med = TextEditingController();
  bool _validate = false;
  final pillTypes = ["Capsule", "Vitamin", "Tablet", "Insulin"];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new medication '),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    "What meds would you like to add? ",
                    style: kTitleStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    }),
                    controller: _med,
                    decoration: InputDecoration(
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        hintText: 'Medicie Name'),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Type",
                    style: kTitleStyle,
                  ),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PillName(
                          name: "Capsule",
                        ),
                        PillName(
                          name: "Vitamin",
                        ),
                        PillName(
                          name: "Tablet",
                        ),
                        PillName(
                          name: "Insulin",
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Name",
                    style: kTitleStyle,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PillName(
                          name: "After Breakfast",
                        ),
                        PillName(
                          name: "After Lunch",
                        ),
                        PillName(name: "+")
                      ]),
                  SizedBox(height: 20),
                  Text(
                    'Choose a date:',
                    style: kHeadStyle,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          _selectedDate == null
                              ? 'No date chosen'
                              : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          style: kTitleStyle),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Choose date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Choose a time:',
                    style: kHeadStyle,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _selectedTime == null
                            ? 'No time chosen'
                            : 'Time: ${_selectedTime!.format(context)}',
                        style: kTitleStyle,
                      ),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: Text('Choose time'),
                      ),
                    ],
                  ),
                  SizedBox(height: 55),
                  Center(
                    child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Set Reminder',
                            style: kHeadStyle,
                          ),
                        ),
                        onPressed: _selectedTime != null &&
                                _selectedDate != null
                            ? () async {
                                // final appointment = Appointment(
                                //     doctor: Daktari(firstName: "firstName", lastName: "lastName", id: "9", specialty:" specialty", availableTimes: "availableTimes"),
                                //     dateTime: DateTime(
                                //         _selectedDate!.year,
                                //         _selectedDate!.month,
                                //         _selectedDate!.day,
                                //         _selectedTime!.hour,
                                //         _selectedTime!.minute),
                                //     userId: FirebaseAuth.instance.currentUser!.uid);
                                final drugrem = DrugSchedule(
                                    dateTime: DateTime(
                                        _selectedDate!.year,
                                        _selectedDate!.month,
                                        _selectedDate!.day,
                                        _selectedTime!.hour,
                                        _selectedTime!.minute));
                                Future<bool> instantNotify() async {
                                  final AwesomeNotifications
                                      awesomeNotifications =
                                      AwesomeNotifications();
                                  return awesomeNotifications.createNotification(
                                      content: NotificationContent(
                                          title: "Quick Doc",
                                          body: "Your drug has been set  ",
                                          bigPicture:
                                              'asset://assets/images/vid.png',
                                          notificationLayout:
                                              NotificationLayout.BigText,
                                          id: Random().nextInt(100),
                                          wakeUpScreen: true,
                                          channelKey: 'instant_notification'));
                                }

                                Future<bool> schedulenotify() async {
                                  final AwesomeNotifications
                                      awesomeNotifications =
                                      AwesomeNotifications();

                                  return await awesomeNotifications
                                      .createNotification(
                                          schedule: NotificationCalendar(
                                              day: _selectedDate!.day,
                                              month: _selectedDate!.month,
                                              year: _selectedDate!.year,
                                              hour: _selectedTime!.hour,
                                              minute: _selectedTime!.minute),
                                          content: NotificationContent(
                                              id: Random().nextInt(100),
                                              title: "Quick Doc",
                                              body: "Take your pill",
                                              wakeUpScreen: true,
                                              notificationLayout:
                                                  NotificationLayout.BigText,
                                              channelKey: 'the_notification'));
                                }

                                FirebaseFirestore.instance
                                    .collection('scheduled_medications')
                                    .add({
                                  'drugName': _med.text,
                                  'userId': user!.uid,
                                  'dateTime':
                                      Timestamp.fromDate(drugrem.dateTime),
                                });
                                instantNotify();
                                schedulenotify();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            Lottie.asset('assets/success.json',
                                                repeat: false),
                                            Text("Booked")
                                          ],
                                        ),
                                        content:
                                            Text('Your drug has been added  '),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return Home();
                                                }));
                                              },
                                              child: Text("OK"))
                                        ],
                                      );
                                    });
                              }
                            : null),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PillName extends StatelessWidget {
  final String name;
  const PillName({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        backgroundColor: Color(0xffd9d9d9),
        // shape: StadiumBorder(),
      ),
      child: Text(
        name,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
