import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/hospitals/hospital_screen.dart';
import 'package:test/features/number_trivia/streams/stream.dart';
import 'package:url_launcher/url_launcher.dart';
import '';

class TestLaunch extends StatefulWidget {
  const TestLaunch({super.key});

  @override
  State<TestLaunch> createState() => _TestLaunchState();
}

class _TestLaunchState extends State<TestLaunch> {
  var url = "https://youtube.com";
  final uri = Uri.parse("https://youtube.com");
  final flutter_uri = Uri.parse('https://flutter.dev');
  final String _phoneNUmber = '0759000575';

  final String date = DateFormat('dd MMM yyyy').format(DateTime.now());
  var day = DateTime.now().day;

  Color? bgColor;
  ColorStream? colorStream;

  changeColor() async {
    // ignore: unused_local_variable
    await for (var eventColor in colorStream!.getColors()) {
      // setState(() {
      //   bgColor = eventColor;
      // });
      void setStateIfMounted(f) {
        if (mounted) {
          setState(() {
            bgColor = eventColor;
          });
        }
      }
    }
  }

  @override
  void initState() {
    colorStream = ColorStream();
    changeColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  // ignore: deprecated_member_use
                  if (!await launchUrl(uri)) {
                    throw 'Could not launch $uri';
                  }
                },
                child: Text("Launch Youtube")),
            ElevatedButton(
                onPressed: () async {
                  // ignore: deprecated_member_use
                  if (!await launchUrl(flutter_uri)) {
                    throw 'Could not launch $flutter_uri';
                  }
                },
                child: Text("Launch Flutter")),
            ElevatedButton(
                onPressed: () async {
                  final text = 'sms:$_phoneNUmber';
                  // ignore: deprecated_member_use
                  if (!await launch(text)) {
                    throw 'Could not launch $text';
                  }
                },
                child: Text("Send text")),
            ElevatedButton(
                onPressed: () async {
                  final call = 'tel:$_phoneNUmber';
                  // ignore: deprecated_member_use
                  if (!await launch(call)) {
                    throw 'Could not launch $call';
                  }
                },
                child: Text("Call Dan")),
            ElevatedButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return HospitalScreen();
                  })));
                },
                child: Text("Call Dan")),
            Text(date),
          ],
        ),
      ),
    );
  }
}
