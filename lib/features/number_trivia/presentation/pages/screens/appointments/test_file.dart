import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/home_tab.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/appointment.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/home.dart';

import '../../schedule/models/doctor.dart';

class AppointmentTestPage extends StatefulWidget {
  final Daktari daktari;
  const AppointmentTestPage({super.key, required this.daktari});

  @override
  _AppointmentTestPageState createState() => _AppointmentTestPageState();
}

class _AppointmentTestPageState extends State<AppointmentTestPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedDoctor;
  String? _selectedReason;
  String? _selectedLocation;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Choose a doctor:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedDoctor,
                hint: Text('Select a doctor'),
                onChanged: (value) {
                  setState(() {
                    _selectedDoctor = value;
                  });
                },
                items: <String>[
                  'Dr. John Doe',
                  'Dr. Jane Smith',
                  'Dr. Mike Johnson'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Choose a reason for your appointment:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedReason,
                hint: Text('Select a reason'),
                onChanged: (value) {
                  setState(() {
                    _selectedReason = value;
                  });
                },
                items: <String>[
                  'Routine checkup',
                  'Sick visit',
                  'Follow-up appointment'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Choose a location:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedLocation,
                hint: Text('Select a location'),
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
                items: <String>[
                  'Main hospital',
                  'Satellite clinic A',
                  'Satellite clinic B'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Choose a date:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Choose date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Choose a time:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedTime == null
                        ? 'No time chosen'
                        : 'Time: ${_selectedTime!.format(context)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    child: Text('Choose time'),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: _selectedTime != null && _selectedDate != null
                        ? () {
                            final appointment = Appointment(
                                doctor: widget.daktari,
                                dateTime: DateTime(
                                    _selectedDate!.year,
                                    _selectedDate!.month,
                                    _selectedDate!.day,
                                    _selectedTime!.hour,
                                    _selectedTime!.minute),
                                userId: FirebaseAuth.instance.currentUser!.uid);
      
                            FirebaseFirestore.instance
                                .collection('doctorappointment')
                                .add({
                              'daktariId': appointment.doctor.id,
                              'dateTime':
                                  Timestamp.fromDate(appointment.dateTime),
                              'userId': appointment.userId,
                              'patient': user!.displayName,
                              'doctor': appointment.doctor.firstName
                            });
      
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        Lottie.asset('assets/success.json'),
                                        Text("Booked")
                                      ],
                                    ),
                                    content: Text(
                                        'Your appointment with Dr.${widget.daktari.firstName} is scheduled for ${DateFormat('EEE, MMM d, h:mm a').format(appointment.dateTime)}'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
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
    );
  }
}
