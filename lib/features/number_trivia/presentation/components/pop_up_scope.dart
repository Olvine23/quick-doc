import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LeaveAppDialog extends StatelessWidget {
  const LeaveAppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Exit App"),
      content: Text("Are you sure you wan't to exit the app? 😟"),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        ElevatedButton(
          child: Text("Yes"),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
      ],
    );
  }
}
