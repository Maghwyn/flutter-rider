import 'package:flutter/material.dart';

class PartyComment extends StatefulWidget {
  const PartyComment({
    super.key,
    required this.comment,
    required this.picture,
    required this.createdAt,
  });

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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Text(widget.comment),
                Text(widget.createdAt.toString()),
                Text(widget.picture),
              ],
            )
          )
        )
      )
    );
  }
}