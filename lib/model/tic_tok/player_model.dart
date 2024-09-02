import 'package:flutter/material.dart';

class PlayerModel {
  String name1;
  String name2;
  PlayerModel(this.name1, this.name2);
}

TextEditingController playerOneController = TextEditingController();
TextEditingController playerTwoController = TextEditingController();
String playerOneName = playerOneController.text;
String playerTwoName = playerTwoController.text;
