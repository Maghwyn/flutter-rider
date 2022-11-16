import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard(
      {super.key,
      required this.icon,
      required this.name,
      required this.email,
      required this.color,
      required this.birthdate});

  final String icon;
  final String name;
  final String email;
  final Color color;
  final String birthdate;

  @override
  State<UserCard> createState() => _UserCard();
}

class _UserCard extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Card(
          color: widget.color,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.vertical,
                children: <Widget>[
                  Center(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.icon),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                width: 1.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 243, 243, 243),
                          border: Border.all(
                              color: const Color.fromARGB(255, 184, 184, 184),
                              width: 1.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                widget.name.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 243, 243, 243),
                          border: Border.all(
                              color: const Color.fromARGB(255, 184, 184, 184),
                              width: 1.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(widget.email,
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 243, 243, 243),
                          border: Border.all(
                              color: const Color.fromARGB(255, 184, 184, 184),
                              width: 1.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(widget.birthdate,
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
