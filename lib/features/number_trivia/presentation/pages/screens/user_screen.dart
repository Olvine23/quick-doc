import 'package:flutter/material.dart';

class DoctorDetailPage extends StatefulWidget {
  final String name;
  final String profession;
  final String imageUrl;

  DoctorDetailPage(
      {required this.name, required this.profession, required this.imageUrl});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2017/03/14/03/20/woman-2141808_960_720.jpg'),
              ),
            ),
          ),
          Text(
            widget.name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            widget.profession,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Additional information about the doctor goes here.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
