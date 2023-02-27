import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppointmentsPage extends StatelessWidget {
  AppointmentsPage({super.key});

  final Stream<QuerySnapshot> appointments =
      FirebaseFirestore.instance.collection('doctorappointment').snapshots();
  @override
  void dispose() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                var snackBar = SnackBar(content: Text('Signed out'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: Icon(Icons.logout))
        ],
        title: Text("Appointment"),
      ),
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
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.size,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Text(data.docs[index]['doctor']),
                          Text(data.docs[index]['patient'])
                        ],
                      );
                    }));
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
