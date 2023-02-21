import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'user_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test/features/number_trivia/presentation/pages/screens/user_screen.dart';

class Chat_Screen extends StatefulWidget {
  final String name;
  final int phone;
  final String company;
  const Chat_Screen(
      {super.key,
      required this.name,
      required this.phone,
      required this.company});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print(users);

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'name': nameController.text, // John Doe
            'company': companyController.text, // Stokes and Sons
            'phone': int.parse(phoneController.text) // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Enter Name")),
            TextFormField(
              controller: companyController,
              decoration: InputDecoration(hintText: 'Company Name'),
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Phone Number'),
            ),
            ElevatedButton(
                onPressed: () {
                  addUser();
                  nameController.clear();
                  phoneController.clear();
                  companyController.clear();
                   
                },
                child: Text("Add")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return InfoUser();
                  })));
                },
                child: Text("Go"))
          ],
        ),
      ),
    ));
  }
}
