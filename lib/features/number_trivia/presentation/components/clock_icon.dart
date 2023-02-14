import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:test/core/utils/colors.dart';

class CustomIcon extends StatelessWidget {
  IconData icon;
  CustomIcon({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 20,
      color: iconColor,
    );
  }
}
