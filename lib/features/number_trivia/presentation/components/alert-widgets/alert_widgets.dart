import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Alerts{

   void sign_out() async {
    AlertDialog(
      content: Text("Sign out"),
    );
    await FirebaseAuth.instance.signOut();
  }

  

  

}