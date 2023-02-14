import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DummyDocs extends StatelessWidget {
  final String name;
  final String img_path;
  final String company;
  const DummyDocs(
      {super.key,
      required this.name,
      required this.img_path,
      required this.company});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 200,
          padding: EdgeInsets.all(12),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      height: 60,
                      width: 50,

                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: AssetImage(img_path))),
                      // child: Image.asset(img_path),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.green[500],
                        child: Text(
                          "Available",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
              ),
              Text(company)
            ],
          ),
        ),
      ),
    );
  }
}
