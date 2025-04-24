import 'package:flutter/material.dart';
import 'package:xo_game/model/tic_tok/player_model.dart';
import 'xo_btn.dart';

enum Difficulty { easy, hard }

class XoGame extends StatefulWidget {
  final String playerOneName;
  final String playerTwoName;
  final bool isVsComputer;
  final Difficulty difficulty;

  const XoGame({
    super.key,
    required this.playerOneName,
    required this.playerTwoName,
    required this.isVsComputer,
    this.difficulty = Difficulty.easy,
  });

  @override
  State<XoGame> createState() => _XoGameState();
}

class _XoGameState extends State<XoGame> {
  List<String> gameBoard = List.filled(9, '');
  int score1 = 0;
  int score2 = 0;
  int counter = 0;
  late bool vsComputer;
  late Difficulty selectedDifficulty;

  @override
  void initState() {
    super.initState();
    vsComputer = widget.isVsComputer;
    selectedDifficulty = widget.difficulty;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/img/xo.jpg",
            fit: BoxFit.cover, width: double.infinity, height: double.infinity),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("X-O Game",
                style: TextStyle(fontSize: 24, color: Colors.white)),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPlayerScore(widget.playerOneName, score1),
                    _buildPlayerScore(widget.playerTwoName, score2),
                  ],
                ),
              ),
              if (vsComputer)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Difficulty:',
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      DropdownButton<Difficulty>(
                        dropdownColor: Colors.black87,
                        value: selectedDifficulty,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedDifficulty = value;
                            });
                          }
                        },
                        items: Difficulty.values.map((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level.name.toUpperCase()),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return XoBtn(
                      label: gameBoard[index],
                      onClick: () => onBtnClick(index),
                      index: index,
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPlayerScore(String name, int score) {
    return Column(
      children: [
        Text(name, style: const TextStyle(fontSize: 22, color: Colors.white)),
        const SizedBox(height: 10),
        Text('$score',
            style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  void onBtnClick(int index) {
    if (gameBoard[index].isNotEmpty) return;

    if (counter.isEven) {
      gameBoard[index] = 'X';
      if (checkWinner('X')) {
        score1 += 10;
        _showResult("🎉 ${widget.playerOneName} Wins!");

        _resetBoard();
      } else {
        counter++;
        if (vsComputer) {
          Future.delayed(const Duration(milliseconds: 300), _playAiMove);
        }
      }
    } else {
      gameBoard[index] = 'O';
      if (checkWinner('O')) {
        score2 += 10;
        _showResult("🎉 ${widget.playerTwoName} Wins!");

        _resetBoard();
      } else {
        counter++;
      }
    }

    if (counter == 9) _resetBoard();
    setState(() {});
  }

  void _playAiMove() {
    int move = _findBestMove();
    if (move != -1) {
      setState(() {
        gameBoard[move] = 'O';
        counter++;
      });

      if (checkWinner('O')) {
        score2 += 10;
        _showResult("🤖 ${widget.playerTwoName} Wins!");

        // Delay the reset so the winning move is visible
        Future.delayed(const Duration(milliseconds: 600), () {
          setState(() {
            _resetBoard();
          });
        });
      } else if (counter == 9) {
        _showResult("😐 It's a Draw!");

        Future.delayed(const Duration(milliseconds: 600), () {
          setState(() {
            _resetBoard();
          });
        });
      }
    }
  }

  int _findBestMove() {
    switch (selectedDifficulty) {
      case Difficulty.easy:
        for (int i = 0; i < gameBoard.length; i++) {
          if (gameBoard[i].isEmpty) return i;
        }
        break;

      case Difficulty.hard:
        return _minimax(gameBoard, true).index;
    }
    return -1;
  }

  bool checkWinner(String symbol) {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (gameBoard[condition[0]] == symbol &&
          gameBoard[condition[1]] == symbol &&
          gameBoard[condition[2]] == symbol) {
        return true;
      }
    }
    return false;
  }

  void _resetBoard() {
    gameBoard = List.filled(9, '');
    counter = 0;
  }

  Move _minimax(List<String> board, bool isAi) {
    if (checkWinner('O')) return Move(index: -1, score: 10);
    if (checkWinner('X')) return Move(index: -1, score: -10);
    if (!board.contains('')) return Move(index: -1, score: 0);

    List<Move> moves = [];

    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) {
        board[i] = isAi ? 'O' : 'X';
        int score = _minimax(board, !isAi).score;
        moves.add(Move(index: i, score: score));
        board[i] = '';
      }
    }

    return isAi
        ? moves.reduce((a, b) => a.score > b.score ? a : b)
        : moves.reduce((a, b) => a.score < b.score ? a : b);
  }

  void _showResult(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
      ),
    );
  }
}

class Move {
  int index;
  int score;

  Move({required this.index, required this.score});
}
