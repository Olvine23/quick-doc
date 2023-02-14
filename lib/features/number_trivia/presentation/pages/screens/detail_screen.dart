import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/features/number_trivia/presentation/widgets/appointment_card.dart';
import 'package:test/features/number_trivia/presentation/widgets/top_doctor.dart';

class DoctorDetail extends StatelessWidget {
  final String name;
  final String about;
  const DoctorDetail({super.key, required this.name, required this.about});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Doctor Details")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height,
              width: double.infinity,
              child: Column(
                children: [Text(name), Text(about)],
              ),
            ),
          ),
        ));
  }
}
