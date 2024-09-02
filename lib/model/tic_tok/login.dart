// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:xo_game/model/tic_tok/player_model.dart';
import 'package:xo_game/model/tic_tok/xo_game.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/img/xo1.jpg",
            fit: BoxFit.fill, width: double.infinity, height: double.infinity),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Login",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  controller: playerOneController,
                  decoration: InputDecoration(
                      label: Text("Player One Name"),
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  controller: playerTwoController,
                  decoration: InputDecoration(
                      label: Text("Player Two name"),
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.deepPurple)
                      // ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              ElevatedButton(
                onPressed: () {
                  playerOneName = playerOneController.text;
                  playerTwoName = playerTwoController.text;
                  if (playerOneName.isNotEmpty && playerTwoName.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => XoGame(
                                  playerOneName: playerOneName,
                                  playerTwoName: playerTwoName,
                                )));
                    playerOneController.clear();
                    playerTwoController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.only(
                        top: 14, bottom: 14, right: 55, left: 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                child: Text(
                  "Go to Game",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
