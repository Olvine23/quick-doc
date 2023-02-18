// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/books.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/another.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/dummy.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/my_books.dart';
import 'package:test/features/number_trivia/presentation/providers/provider_file.dart';
import 'package:test/features/number_trivia/presentation/widgets/category_icons.dart';
import 'package:test/features/number_trivia/presentation/widgets/search_input.dart';
import 'package:test/features/number_trivia/presentation/widgets/title_row.dart';
import 'package:test/features/number_trivia/presentation/widgets/user_intro.dart';
import 'package:intl/intl.dart';

import '../../widgets/appointment_card.dart';
import '../../widgets/slide_card.dart';
import '../../widgets/top_doc.dart';
import '../../widgets/top_doctor.dart';

final user = FirebaseAuth.instance.currentUser;

List<Map> doctors = [
  {
    'img': 'assets/images/female_doc.png',
    'doctorName': 'Dr. Gardner Pearson',
    'doctorTitle': 'Heart Specialist'
  },
  {
    'img': 'assets/images/doctor.png',
    'doctorName': 'Dr. Rosa Williamson',
    'doctorTitle': 'Skin Specialist'
  },
  {
    'img': 'assets/images/doctor.png',
    'doctorName': 'Dr. Gardner Pearson',
    'doctorTitle': 'Heart Specialist'
  },
  {
    'img': 'assets/images/doctor.png',
    'doctorName': 'Dr. Rosa Williamson',
    'doctorTitle': 'Skin Specialist'
  }
];

class HomeTab extends StatelessWidget {
  final void Function() onPressedScheduleCard;

  const HomeTab({
    Key? key,
    required this.onPressedScheduleCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            UserIntro(),
            SizedBox(
              height: 10,
            ),
            SearchInput(),

            SizedBox(
              height: 20,
            ),
            CategoryIcons(),
            SizedBox(
              height: 20,
            ),
            Title_row(),
            SizedBox(
              height: 20,
            ),
            AppointmentCard(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyBooks();
                }));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Top Doctors',
              style: TextStyle(
                color: Color(CustomColors.header01),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // SlideCard(onPressedScheduleCard: onPressedScheduleCard),
            // ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: doctors.length,
            //     itemBuilder: ((context, index) {
            //       return TopDoctorCard(
            //           img: [index].,
            //           doctorName: ['doctorName'][index],
            //           doctorTitle: ['doctorTitle'][index]);
            //     })),
            TopDoctorCard()
          ],
        ),
      ),
    );
  }
}

List<Map> categories = [
  {'icon': Icons.dangerous, 'text': 'Critical'},
  {'icon': Icons.local_hospital, 'text': 'Hospital'},
  {'icon': Icons.car_rental, 'text': 'Ambulance'},
  {'icon': Icons.local_pharmacy, 'text': 'Pill'},
];
