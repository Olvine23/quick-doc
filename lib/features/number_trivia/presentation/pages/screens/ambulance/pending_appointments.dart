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
      .collection('scheduled_medications_update')
      .orderBy('dateTime')
      .snapshots();

  Future deleteData(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("scheduled_medications_update")
          .doc(id)
          .delete();
    } catch (e) {
      return false;
    }
  }

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
                      StreamBuilder<QuerySnapshot>(
                          stream: prescription,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("error");
                            }
                            if (snapshot.hasData) {
                              final data = snapshot.requireData;
                              return Container(
                                height: 180,
                                child: ListView.builder(
                                    itemCount: 2,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
                                      return CustomCard(
                                        name: data.docs[index]['drugName'],
                                        color: "2a1214",
                                        number: DateFormat('EEE, MMM d, h:mm a')
                                            .format(data.docs[index]['dateTime']
                                                .toDate()),
                                        image:
                                            "https://static.vecteezy.com/system/resources/previews/002/896/807/original/female-doctor-using-her-digital-tablet-free-vector.jpg",
                                        valid: "VALID 10/22",
                                      );
                                    })),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
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
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ListTile(
                                    onTap: () {
                                      _settingModalBottomSheet(
                                          data.docs[index]['drugName']);
                                    },
                                    leading: const CircleAvatar(
                                      // backgroundImage: AssetImage("images/p3.jpg"),
                                      backgroundImage: NetworkImage(
                                          'https://media.healthdirect.org.au/images/medicines/guildImages/78692/78692-C01-BL600.jpg'),
                                    ),
                                    title: Text(
                                      data.docs[index]['drugName'],
                                      style: kTitleStyle,
                                    ),
                                    subtitle: Text(
                                        DateFormat('EEE, MMM d, h:mm a').format(
                                            data.docs[index]['dateTime']
                                                .toDate())),
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
                                          DateFormat(' h:mm a').format(data
                                              .docs[index]['dateTime']
                                              .toDate()),
                                          style: kTitleStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(String name) {
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
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text("Quantity remaining"),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "$money",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 10,
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
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
