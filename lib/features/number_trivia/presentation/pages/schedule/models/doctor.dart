import 'package:flutter/material.dart';

class Daktari {
  final String id;
  final String firstName;
  final String lastName;
  final String specialty;
  final List<TimeOfDay> availableTimes;

  Daktari({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.specialty,
    required this.availableTimes,
  });
}
