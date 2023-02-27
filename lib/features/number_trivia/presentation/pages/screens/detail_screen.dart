import 'package:flutter/material.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/doctor.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/appointments/test_file.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/doctors/daktari_details.dart';

class DoctorDetail extends StatelessWidget {
  final String firstName;
  final String lastName;
  final List<TimeOfDay> availableTimes;
  final String about;
  final int phone;
  final String specialty;
  final String img;
  const DoctorDetail(
      {super.key,
      required this.availableTimes,
      required this.specialty,
      required this.lastName,
      required this.firstName,
      required this.about,
      required this.phone,
      required this.img});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final doctor = Daktari(
        firstName: firstName,
        lastName: lastName,
        id: '10',
        specialty: specialty,
        availableTimes: availableTimes);
    return Scaffold(
        // appBar: AppBar(title: Text("Doctor Details")),
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
            width: double.infinity,
            height: size.height,
            child: Stack(
              children: [
                Hero(
                  tag: "Joe",
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  img,
                                )))),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  bottom: -8,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            child: const Text('Back'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text('Proceed',
                                  style: kTitleStyleWithWhiteColor),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AppointmentTestPage(daktari: doctor,);
                                  // return DaktariDetailsScreen(daktari: doctor);
                                }));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: MediaQuery.of(context).size.height / 2 - 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        const Icon(
                                          Icons.video_call,
                                          color: Colors.blue,
                                        ),
                                        const Text('Video Call',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        const Icon(
                                          Icons.call,
                                          color: Colors.green,
                                        ),
                                        const Text('Voice Call',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        const Icon(
                                          Icons.chat_bubble_rounded,
                                          color: Colors.blue,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) {
                                            //   return DaktariDetailsScreen(
                                            //       daktari: doctor);
                                            // }));
                                          },
                                          child: Text('Chat',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(img),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('$firstName $lastName',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          specialty,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color(CustomColors.grey02)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(about,
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ))
      ]),
    ));
  }
}
