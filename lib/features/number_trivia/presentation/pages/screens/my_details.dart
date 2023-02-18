import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class MyDetals extends StatefulWidget {

  MyDetals({super.key});

  @override
  State<MyDetals> createState() => _MyDetalsState();
}

class _MyDetalsState extends State<MyDetals> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  
  void dispose() {
    Connectivity().onConnectivityChanged;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(user!.displayName);
    print(user!.photoURL);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          user!.photoURL == null
              ? Image.asset('assets/images/vid.png')
              : Image.network(user!.photoURL.toString()),
          StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User? user = snapshot.data;
                  if (user != null) {
                    return Text("Signed in as ${user!.displayName}");
                  } else
                    return Text("None");
                }
                return CircularProgressIndicator();
              })),
          ElevatedButton(
              onPressed: () {
                var snackBar = SnackBar(content: Text('Signed out'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                FirebaseAuth.instance.signOut();
              },
              child: Text("Sign Out"))
        ],
      )),
    );
  }
}
