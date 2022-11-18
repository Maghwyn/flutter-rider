import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorseCard extends StatefulWidget {
  const HorseCard({
    super.key,
    required this.name,
    required this.age,
    required this.robe,
    required this.race,
    required this.sexe,
    required this.picture,
    required this.isMine,
  });

  final String name;
  final String age;
  final String robe;
  final String race;
  final String picture;
  final String sexe;
  final bool isMine;

  @override
  State<HorseCard> createState() => _HorseCard();
}

class _HorseCard extends State<HorseCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3))),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.picture),
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
                      spacing: 4,
                      children: [
                        Text(widget.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.age,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.robe,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                         Text(widget.race,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.sexe,
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
    );
  }
}