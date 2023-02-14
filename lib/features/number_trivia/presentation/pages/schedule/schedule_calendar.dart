import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({super.key});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  final _formKey = GlobalKey<FormState>();
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add an event",
                      style: TextStyle(fontSize: 26),
                    ),
                    TextFormField(
                      controller: _text,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            Text(_text.text)
          ],
        ),
      ),
    ));
  }
}
