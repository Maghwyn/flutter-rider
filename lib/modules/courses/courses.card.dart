import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    required this.terrain,
    required this.date,
    required this.duration,
    required this.speciality,
    required this.isMine,
  });

  final String terrain;
  final DateTime date;
  final String duration;
  final String speciality;
  final bool isMine;

  @override
  State<CourseCard> createState() => _CourseCard();
}

class _CourseCard extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        color: widget.isMine ? Colors.amber : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Text(widget.terrain),
                Text(widget.date.toString()),
                Text(widget.duration == "1" ? "1 hour" : "30 minutes"),
                Text(widget.speciality),
              ],
            )
          )
        )
      )
    );
  }
}