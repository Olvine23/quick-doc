 
import 'package:flutter/material.dart';

class Dialog {
  Dialog(wrongEmail);
  void wrongEmail(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text("Wrong email address"),
          );
        }));
  }
}
