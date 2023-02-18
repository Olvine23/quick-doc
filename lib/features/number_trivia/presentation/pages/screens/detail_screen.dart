import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/features/number_trivia/presentation/widgets/appointment_card.dart';
import 'package:test/features/number_trivia/presentation/widgets/top_doctor.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorDetail extends StatelessWidget {
  final String name;
  final String about;
  final int phone;
  final String img;
  const DoctorDetail(
      {super.key,
      required this.name,
      required this.about,
      required this.phone,
      required this.img});

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
                children: [
                  Card(
                    margin: EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return DoctorDetail(
                        //     name: name,
                        //     about: about,
                        //     phone: phone,
                        //   );
                        // }));
                      },
                      child: Row(
                        children: [
                          Container(
                            color: Color(CustomColors.grey01),
                            child: Image(
                              width: 100,
                              image: AssetImage(img),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  color: Color(CustomColors.header01),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                name,
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
                                    style: TextStyle(
                                        color: Color(CustomColors.grey02)),
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon: Icon(Icons.favorite_outline)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name),
                      ElevatedButton(
                          onPressed: () async {
                            final call = 'tel:$phone';
                            if (!await launch(call)) {
                              throw ('Couldnt launch $phone.toString()');
                            }
                            ;
                          },
                          child: Text("Call"))
                    ],
                  ),
                  Text(about),
                  Text(phone.toString())
                ],
              ),
            ),
          ),
        ));
  }
}
