import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/books.dart';
import 'package:test/features/number_trivia/presentation/widgets/appointment_card.dart';
import 'package:test/features/number_trivia/presentation/widgets/schedule_card.dart';
import 'package:test/features/number_trivia/presentation/widgets/user_intro.dart';
import './pill_description.dart';

import '../../../../../../core/styles/colors.dart';
import '../../welcome/my_books.dart';

class PillsPage extends StatefulWidget {
  const PillsPage({super.key});

  @override
  State<PillsPage> createState() => _PillsPageState();
}

class _PillsPageState extends State<PillsPage> {

  @override
  void initState() {
    
    super.initState();
    
  }
  final Stream<QuerySnapshot> prescription = FirebaseFirestore.instance
      .collection('scheduled_medications').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PillDescription();
              }));
            }),
        appBar: AppBar(
          title: Text("Mobi Chemist"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                UserIntro(),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Todays pills",
                    style: kTitleStyle,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: prescription,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("error");
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.requireData;
                        return ListView.builder(
                            itemCount: data.size,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.docs[index]['drugName']),
                                  Text(DateFormat('EEE, MMM d, h:mm a').format(
                                      data.docs[index]['dateTime'].toDate())),
                                ],
                              );
                            }));
                      }
                      return CircularProgressIndicator();
                    }),
              ],
            ),
          ),
        ));
  }
}
