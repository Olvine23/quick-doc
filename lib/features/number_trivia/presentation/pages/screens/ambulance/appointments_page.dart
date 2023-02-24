import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppointmentsPage extends StatelessWidget {
  AppointmentsPage({super.key});

  final Stream<QuerySnapshot> appointments =
      FirebaseFirestore.instance.collection('appointmentsing').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: appointments,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error"));
              }
              if (snapshot.hasData) {
                final data = snapshot.requireData;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.size,
                    itemBuilder: ((context, index) {
                      return Text(data.docs[index]['daktariId'].toString());
                    }));
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
