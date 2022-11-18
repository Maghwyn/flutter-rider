import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PartyComment extends StatefulWidget {
  const PartyComment({
    super.key,
    required this.comment,
    required this.name,
    required this.picture,
    required this.createdAt,
  });

  final String name;
  final String comment;
  final DateTime createdAt;
  final String picture;

  @override
  State<PartyComment> createState() => _PartyComment();
}

class _PartyComment extends State<PartyComment> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        color: Colors.deepPurple[50],
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Wrap(
                  spacing: 20,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.picture),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 1.5
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.center,
                      spacing: 10,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 5,
                          children: [
                            Text("${widget.name} - ${DateFormat("yyyy-MM-dd").format(widget.createdAt)}",
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.comment,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            )
          ),
        )
      )
    );
  }
}