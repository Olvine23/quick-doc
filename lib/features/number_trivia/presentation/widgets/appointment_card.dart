// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/my_books.dart';

import '../components/tabs/home_tab.dart';
import '../pages/schedule/models/books.dart';
import 'schedule_card.dart';

class Student {
  String? name;
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;
  String? individ;
  getDetails() async {
    var box = await Hive.openBox<Books>('booksBox');

    print(box.values.toList());
    print(individ);
  }

  final boxProvider = FutureProvider((ref) async {
    var box = await Hive.openBox<Books>('booksBox');
    return box;
  });

  AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  // @override
  // // ignore: override_on_non_overriding_member
  // initState() {
  //   getDetails();
  // }

  @override
  Widget build(BuildContext context) {
    // print(getDetails());
    // print(Student().name);

    return ValueListenableBuilder(
      valueListenable: Hive.box<Books>('booksBox').listenable(),
      builder: (BuildContext context, Box<Books> boxie, _) {
        if (boxie.values.isNotEmpty) {
          // var date = boxie.getAt(0)?.date.toString();
          var doccie = boxie.getAt(0)?.author.toString();
          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(CustomColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/doctor.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable:
                                          Hive.box<Books>('booksBox')
                                              .listenable(),
                                      builder: ((context, Box<Books> books, _) {
                                        var docc =
                                            books.getAt(0)?.doc.toString();
                                        if (books.values.isEmpty) {
                                          return Text("data");
                                        } else
                                          // ignore: avoid_print
                                          print(docc);

                                        print(books.getAt(0)?.doc!);
                                        return Text(docc.toString(),
                                            style:
                                                TextStyle(color: Colors.white));
                                      })),
                                  // Text('Dr. Kamau Mwitu',
                                  //     style: TextStyle(color: Colors.white)),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    doccie!,
                                    // "James",
                                    style: TextStyle(
                                        color: Color(CustomColors.text01)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ScheduleCard(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(CustomColors.bg02),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(CustomColors.bg03),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ],
          );
        } else
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return MyBooks();
              })));
            },
            child: Center(
              child: SizedBox(
                height: 290,
                child: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_fmieo0wt.json'),
              ),
            ),
          );
      },
    );
  }
}
