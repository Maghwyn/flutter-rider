import 'package:flutter/material.dart';

class CompetitionCard extends StatefulWidget {
  const CompetitionCard({
    super.key,
    required this.name,
    required this.date,
    required this.adress,
    required this.picture,
  });

  final String name;
  final DateTime date;
  final String adress;
  final String picture;

  @override
  State<CompetitionCard> createState() => _CompetitionCard();
}

class _CompetitionCard extends State<CompetitionCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Column(
                      children: [
                        Text(widget.name),
                        Text(widget.date.toString()),
                        Text(widget.adress),
                        Image(image: NetworkImage(widget.picture),),
                      ],
                    )
                )
            )
        )
    );
  }
}