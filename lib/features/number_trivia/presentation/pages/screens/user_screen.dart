import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoUser extends StatelessWidget {
  InfoUser({super.key});

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    print(users.length);
    return Scaffold(
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
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.docs[index]['name']),
                          Text(data.docs[index]['company'])
                        ]);
                  })),
            ));
          }
          return CircularProgressIndicator();
        },
        stream: users,
      ),
    );
  }
}
