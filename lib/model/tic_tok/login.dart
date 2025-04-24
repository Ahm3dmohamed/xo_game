import 'package:flutter/material.dart';
import 'package:xo_game/model/tic_tok/xo_game.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isComputer = false;
  final TextEditingController playerOneController = TextEditingController();
  final TextEditingController playerTwoController = TextEditingController();

  @override
  void dispose() {
    playerOneController.dispose();
    playerTwoController.dispose();
    super.dispose();
  }

  void _startGame() {
    final playerOneName = playerOneController.text.trim();
    final playerTwoName = isComputer ? "AI" : playerTwoController.text.trim();

    if (playerOneName.isEmpty || playerTwoName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required names.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => XoGame(
          playerOneName: playerOneName,
          playerTwoName: playerTwoName,
          isVsComputer: isComputer,
        ),
      ),
    );

    playerOneController.clear();
    playerTwoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/img/xo1.jpg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Login", style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Select Game Mode",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text("Player vs Player"),
                        selected: !isComputer,
                        onSelected: (_) => setState(() => isComputer = false),
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text("Player vs Computer"),
                        selected: isComputer,
                        onSelected: (_) => setState(() => isComputer = true),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: TextField(
                      controller: playerOneController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Player One Name",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  if (!isComputer)
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: TextField(
                        controller: playerTwoController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "Player Two Name",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _startGame,
                    child: const Text("Start Game",
                        style: TextStyle(fontSize: 18)),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
