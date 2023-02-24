import 'package:test/features/number_trivia/presentation/pages/schedule/models/doctor.dart';

class Appointment {
  final Daktari doctor;
  final DateTime dateTime;
  final String userId;

  Appointment({required this.doctor, required this.dateTime, required this.userId} );
}
