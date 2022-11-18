import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    required this.terrain,
    required this.date,
    required this.duration,
    required this.speciality,
    required this.isMine,
    required this.status,
  });

  final String terrain;
  final DateTime date;
  final String duration;
  final String speciality;
  final String status;
  final bool isMine;

  @override
  State<CourseCard> createState() => _CourseCard();
}

class _CourseCard extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        color: widget.status != "done" ? Colors.deepPurple[50] : Colors.red[50],
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3))),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: widget.status != "done" ? const Color.fromARGB(255, 103, 38, 172) : Colors.red, width: 5),
              ),
            ),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.terrain == "Arena"
                        ? "https://ruralbuildermagazine.com/wp-content/uploads/2021/08/LegacySteelBuildingsHeader.jpg"
                        : "https://www.boturfers.fr/themes/boturfer/img/hippodrome-nice.jpg"
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      width: 1.5
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: 10,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 10,
                        children: [
                          Text(widget.speciality,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("- ${widget.duration == "1" ? "1 hour" : "30 minutes"}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text("- ${DateFormat("yyyy-MM-dd").format(widget.date)}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text("- Status : ${widget.status}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: widget.isMine ? const Icon(Icons.person, color: Colors.purple, size: 40) : null,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}