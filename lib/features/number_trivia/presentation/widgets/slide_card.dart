import 'package:flutter/material.dart';
import 'package:test/features/number_trivia/presentation/widgets/appointment_card.dart';

class SlideCard extends StatelessWidget {
  const SlideCard({
    Key? key,
    required this.onPressedScheduleCard,
  }) : super(key: key);

  final void Function() onPressedScheduleCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 9,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              width: 340,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppointmentCard(
                  onTap: onPressedScheduleCard, title: '', subtitle: '',
                ),
              ),
            );
          }),
    );
  }
}
