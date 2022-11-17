import 'package:flutter/material.dart';

RegExp emailFormat = RegExp(
  r"^(?=.{2,42}@)[0-9a-zA-Z]+(?:[+\.-][0-9a-z]+)*@((?=.{3,64}$)[a-z0-9]{1,}(?:-{1,3}[a-z]{1,})?(?:\.[a-z]{0})?)+(?:[a-z]{1,}\.[a-z]{2,})(?!.)+",
  caseSensitive: false,
  multiLine: false,
);

List<DropdownMenuItem<String>> courseTerrainItems = [
  const DropdownMenuItem(value: "Hippodrome", child: Text("Hippodrome")),
  const DropdownMenuItem(value: "Arena", child: Text("Arena")),
];

List<DropdownMenuItem<String>> courseDurationItems = [
  const DropdownMenuItem(value: "0.5", child: Text("30 minutes")),
  const DropdownMenuItem(value: "1", child: Text("1 hour")),
];

List<DropdownMenuItem<String>> courseSpecialityItems = [
  const DropdownMenuItem(value: "Training", child: Text("Training")),
  const DropdownMenuItem(value: "Show Jumping", child: Text("Show Jumping")),
  const DropdownMenuItem(value: "Stamina", child: Text("Stamina")),
];

List<DropdownMenuItem<String>> partyTypeItems = [
  const DropdownMenuItem(value: "1", child: Text("Pre-Dinner")),
  const DropdownMenuItem(value: "2", child: Text("Dinner")),
];