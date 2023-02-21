import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/core/styles/colors.dart';

class InfoUser extends StatelessWidget {
  InfoUser({super.key});

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    print(users.length);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.medical_information),
        title: Text("Doctors"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }

          if (snapshot.hasData) {
            final data = snapshot.requireData;
            print(data.size);
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: data.size,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Card(
                          margin: EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //     // return DoctorDetail(
                              //     //   name: doctors[index].firstName,
                              //     //   about: doctors[index].about,
                              //     //   phone: doctors[index].phone,
                              //     //   img: doctors[index].image,
                              //     // );
                              //   }));
                              // },
                            },
                            child: Row(
                              children: [
                                Container(
                                  color: Color(CustomColors.grey01),
                                  child: Image(
                                    width: 100,
                                    image: AssetImage('assets/images/vid.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.docs[index]['name'],
                                      style: TextStyle(
                                        color: Color(CustomColors.header01),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data.docs[index]['company'],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                              color:
                                                  Color(CustomColors.grey02)),
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
                                      var snackBar = SnackBar(
                                          content: Text('Favorite Pressed'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    icon: Icon(Icons.favorite_outline)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            ));
          }
          return Center(child: CircularProgressIndicator());
        },
        stream: users,
      ),
    );
  }
}
