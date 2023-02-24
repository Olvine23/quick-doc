import 'package:flutter/material.dart';

class Daktari {
  final String id;
  final String name;
  final String specialty;
  final List<TimeOfDay> availableTimes;

  Daktari({required this.id, required this.name, required this.specialty, required this.availableTimes});
}
