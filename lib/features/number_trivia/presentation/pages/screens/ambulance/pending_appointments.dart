// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/pills/pill_description.dart';
import 'package:test/features/number_trivia/presentation/widgets/appointment_card.dart';
import 'package:test/features/number_trivia/presentation/widgets/custom_card.dart';

class PendingDrugs extends StatefulWidget {
  PendingDrugs({super.key});

  @override
  State<PendingDrugs> createState() => _PendingDrugsState();
}

class _PendingDrugsState extends State<PendingDrugs> {
  double money = 50.00;
  final Stream<QuerySnapshot> prescription = FirebaseFirestore.instance
      .collection('scheduled_medications')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PillDescription();
          }));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(CustomColors.bg02),

                  // color: Color(CustomColors.primary),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60))),
            ),
            SafeArea(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BackButton(onPressed: () {
                        Navigator.pop(context);
                      }),
                      Text(
                        "My Drugs",
                        style: kHeadStyle,
                      ),
                      IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                            size: 40,
                          ),
                          onPressed: () {})
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Upcoming Medication",
                            style: kTitleStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CustomCard(
                              name: 'uuu',
                              color: "2a1214",
                              number: 9290,
                              image:
                                  "https://static.vecteezy.com/system/resources/previews/002/896/807/original/female-doctor-using-her-digital-tablet-free-vector.jpg",
                              valid: "VALID 10/22",
                            ),
                            CustomCard(
                              name: 'wrwrw',
                              color: "000068",
                              number: 1298,
                              image:
                                  "https://static.vecteezy.com/system/resources/previews/002/896/807/original/female-doctor-using-her-digital-tablet-free-vector.jpg",
                              valid: "VALID 07/24",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),

                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Today's Medication",
                        style: kHeadStyle,
                      ),
                    ),
                  ],
                ),
                // StreamBuilder<QuerySnapshot>(
                //     stream: prescription,
                //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //       if (snapshot.hasError) {
                //         return Text("error");
                //       }
                //       if (snapshot.hasData) {
                //         final data = snapshot.requireData;
                //         return Container(
                //           height: 180,
                //           child: ListView.builder(
                //               scrollDirection: Axis.horizontal,
                //               itemCount: data.size,
                //               shrinkWrap: true,
                //               itemBuilder: ((context, index) {
                //                 return CustomCard(
                //                   name: data.docs[index]['drugName'],
                //                   color: "2a1214",
                //                   number: 9290,
                //                   image:
                //                       "https://static.vecteezy.com/system/resources/previews/002/896/807/original/female-doctor-using-her-digital-tablet-free-vector.jpg",
                //                   valid: "VALID 10/22",
                //                 );
                //               })),
                //         );
                //       }
                //       return CircularProgressIndicator();
                //     }),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListTile(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      leading: const CircleAvatar(
                        // backgroundImage: AssetImage("images/p3.jpg"),
                        backgroundImage: NetworkImage(
                            'https://media.healthdirect.org.au/images/medicines/guildImages/78692/78692-C01-BL600.jpg'),
                      ),
                      title: RichText(
                          text: const TextSpan(children: [
                        TextSpan(text: 'Marley Geremy\n'),
                        TextSpan(
                            text: 'Money Sent - Today 9AM',
                            style: TextStyle(fontSize: 14, color: Colors.grey))
                      ], style: TextStyle(color: Colors.black, fontSize: 18))),
                      trailing: Column(
                        children: [
                          Icon(
                            Icons.access_alarm_rounded,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "6:00pm",
                            style: kTitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListTile(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.ctfassets.net/ip74mqmfgvqf/18lOlrKFiYUWEo0aUMIO8S/5f0eb64065af3938e84ceaacbfad0d6b/FRANK_drug_image_tranquilisers.jpg')),
                      // backgroundImage: AssetImage("images/p2.jpg"),

                      title: RichText(
                          text: const TextSpan(children: [
                        TextSpan(text: 'Jason Martin\n'),
                        TextSpan(
                            text: 'Money received - Today 12PM',
                            style: TextStyle(fontSize: 14, color: Colors.grey))
                      ], style: TextStyle(color: Colors.black, fontSize: 18))),
                      trailing: const Text(
                        "+ \$220",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            // ignore: unnecessary_new
            child: new Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            "https://media.healthdirect.org.au/images/medicines/guildImages/78692/78692-C01-BL600.jpg"),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Jason Martin",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text("Amount to send"),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                          onTap: () {
                            if (money != 0) {
                              money -= 10;
                            }
                          },
                          child: const CircleAvatar(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            radius: 20,
                            backgroundColor: Colors.grey,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$money",
                      style: const TextStyle(
                          fontSize: 38, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              money += 10;
                            });
                          },
                          child: const CircleAvatar(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            radius: 20,
                            backgroundColor: Colors.grey,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xff037ef3),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Take Pill",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
