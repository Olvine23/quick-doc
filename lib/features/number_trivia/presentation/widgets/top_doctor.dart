import 'package:flutter/material.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/utils/colors.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/doctor.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/chat_screen.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/detail_screen.dart';

import '../models/doctor.dart';

class TopDoctorCard extends StatelessWidget {
  List<Doc> doctors = <Doc>[];
  List<Daktari> daktari = <Daktari>[];
  List<Chat_Screen> members = <Chat_Screen>[];

  @override
  Widget build(BuildContext context) {
    
    members.add(Chat_Screen(name: "Olly", phone: 033, company: "MMuSR"));
    doctors.add(Doc(
        'Olvine',
        "George",
        'assets/images/vid.png',
        'Kasuku',
        254791591040,
        'A doctor profile typically includes information such as the doctors name, photo, education and training background, specialties, and any additional certifications or awards. '));
    doctors.add(Doc(
        'Kamau',
        "Kimwi",
        'assets/images/black_doc.png',
        'General',
        0727501616,
        'A doctor profile typically includes information such as the doctors name, photo, education and training background, specialties, and any additional certifications or awards.'));

    doctors.add(Doc('Prisca', "Atienos", 'assets/images/prisca.jpg', 'USIU', 6,
        'A doctor profile typically includes information such as the doctors name, photo, education and training background, specialties, and any additional certifications or awards. '));
    print(doctors.length);
    print(members.length);
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: doctors.length,
        itemBuilder: ((context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DoctorDetail(
                    availableTimes: [
                      TimeOfDay(hour: 8, minute: 0),
                      TimeOfDay(hour: 9, minute: 0),
                      TimeOfDay(hour: 10, minute: 0),
                    ],
                    specialty: "Dentist",
                    firstName: doctors[index].firstName,
                    lastName: doctors[index].lastName,
                    about: doctors[index].about,
                    phone: doctors[index].phone,
                    img: doctors[index].image,
                  );
                }));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Color(CustomColors.grey01),
                      child: Image(
                        width: 100,
                        image: AssetImage(doctors[index].image),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${doctors[index].firstName} ${doctors[index].lastName} ',
                        style: TextStyle(
                          color: Color(CustomColors.header01),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctors[index].hospital,
                        style: TextStyle(
                          color: Color(CustomColors.grey02),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(CustomColors.yellow02),
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '4.0 - 50 Reviews',
                            style: TextStyle(color: Color(CustomColors.grey02)),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                      onPressed: () {
                        var snackBar =
                            SnackBar(content: Text('Favorite Pressed'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: Icon(Icons.favorite_outline)),
                ],
              ),
            ),
          );
        }));
  }
}
