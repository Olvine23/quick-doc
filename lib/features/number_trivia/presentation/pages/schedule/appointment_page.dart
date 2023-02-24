import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/features/number_trivia/presentation/components/tabs/home_tab.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 9, minute: 0);
  final Stream<QuerySnapshot> appointments =
      FirebaseFirestore.instance.collection('appointments').snapshots();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = picked.toString();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void _submitForm() async {
    final _auth = FirebaseAuth.instance;
    if (user == null) {
      return;
    }

    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('appointments').add({
        'userId': user!.uid,
        'date': _selectedDate,
        'time': _selectedTime.format(context),
        'type': _typeController.text,
        'location': _locationController.text,
        'details': _detailsController.text,
      });

      // Send a confirmation email or notification to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Appoitment"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _timeController,
                      onTap: () {
                        _selectTime(context);
                      },
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText: 'Select time',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a time';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dateController,
                      onTap: () {
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'Select date',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _typeController,
                      decoration: InputDecoration(
                        labelText: 'Type of Appointment',
                        hintText: 'Enter type of appointment',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the type of appointment';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        hintText: 'Enter location',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _detailsController,
                      decoration: InputDecoration(
                        labelText: 'Details',
                        hintText: 'Enter any additional details',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                  ],
                )),
            StreamBuilder<QuerySnapshot>(
                stream: appointments,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Has error");
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    print(data.size);
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: data.size,
                        itemBuilder: ((context, index) {
                          print(data);
                          return Center(
                              child: Column(
                            children: [
                              Text(data.docs[index]['type']),
                            ],
                          ));
                        }));
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
