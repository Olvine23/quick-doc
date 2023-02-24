import 'package:flutter/material.dart';
import '../../schedule/models/doctor.dart';
import 'daktari_details.dart';
 

class DaktarisScreen extends StatelessWidget {

  DaktarisScreen({super.key});
  final List<Daktari> daktaris = [
    Daktari(id: '1', name: 'Dr. John Doe', specialty: 'Dermatology', availableTimes: [
      TimeOfDay(hour: 8, minute: 0),
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 10, minute: 0),
    ]),
    Daktari(id: '2', name: 'Dr. Jane Smith', specialty: 'Pediatrics', availableTimes: [
      TimeOfDay(hour: 10, minute: 0),
      TimeOfDay(hour: 11, minute: 0),
      TimeOfDay(hour: 12, minute: 0),
    ]),
  ];



    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Daktari'),
      ),
      body: ListView.builder(
        itemCount: daktaris.length,
        itemBuilder: (BuildContext context, int index) {
          final doctor = daktaris[index];
          return ListTile(
            title: Text(doctor.name),
            subtitle: Text(doctor.specialty),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DaktariDetailsScreen(daktari: doctor  )),
              );
            },
          );
        },
      ),
    );
  }
}
