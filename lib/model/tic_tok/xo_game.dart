import 'package:flutter/material.dart';
import 'package:xo_game/model/tic_tok/player_model.dart';
import 'xo_btn.dart';

class XoGame extends StatefulWidget {
  final String playerOneName;
  final String playerTwoName;

  const XoGame(
      {super.key, required this.playerOneName, required this.playerTwoName});
  @override
  State<XoGame> createState() => _XoGameState();
}

class _XoGameState extends State<XoGame> {
  int counter = 0;
  int score1 = 0;
  int score2 = 0;

  List<String> gameBoard = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/img/xo.jpg",
            fit: BoxFit.fill, width: double.infinity, height: double.infinity),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              "X-O Game",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Text(
                            playerOneName,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            "$score1",
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Text(
                            playerTwoName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            "$score2",
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    XoBtn(
                      label: gameBoard[0],
                      onClick: onBtnClick,
                      index: 0,
                    ),
                    XoBtn(
                      label: gameBoard[1],
                      onClick: onBtnClick,
                      index: 1,
                    ),
                    XoBtn(
                      label: gameBoard[2],
                      onClick: onBtnClick,
                      index: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    XoBtn(
                      label: gameBoard[3],
                      onClick: onBtnClick,
                      index: 3,
                    ),
                    XoBtn(
                      label: gameBoard[4],
                      onClick: onBtnClick,
                      index: 4,
                    ),
                    XoBtn(
                      label: gameBoard[5],
                      onClick: onBtnClick,
                      index: 5,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    XoBtn(
                      label: gameBoard[6],
                      index: 6,
                      onClick: onBtnClick,
                    ),
                    XoBtn(
                      label: gameBoard[7],
                      index: 7,
                      onClick: onBtnClick,
                    ),
                    XoBtn(
                      label: gameBoard[8],
                      index: 8,
                      onClick: onBtnClick,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  bool checkWinner(String symbol) {
    //check Row
    for (int i = 0; i < 9; i += 3) {
      if (gameBoard[i] == symbol &&
          gameBoard[i + 1] == symbol &&
          gameBoard[i + 2] == symbol) {
        return true;
      }
    }

    //check column
    for (int i = 0; i < 3; i++) {
      if (gameBoard[i] == symbol &&
          gameBoard[i + 3] == symbol &&
          gameBoard[i + 6] == symbol) {
        return true;
      }
    }
    //check border

    if (gameBoard[0] == symbol &&
        gameBoard[4] == symbol &&
        gameBoard[8] == symbol) {
      return true;
    } else if (gameBoard[2] == symbol &&
        gameBoard[4] == symbol &&
        gameBoard[6] == symbol) {
      return true;
    } else
      // ignore: curly_braces_in_flow_control_structures
      return false;
  }

  void reset() {
    gameBoard = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];
    counter = 0;
  }

  onBtnClick(index) {
    if (counter.isEven) {
      gameBoard[index] = 'X';
      bool win = checkWinner("X");
      // score1 += 2;

      if (win) {
        score1 += 10;
        reset();
        // return  Text("${widget.playerOneName}   أشطر كتكوووت");
      } else {
        counter++;
      }
    } else {
      gameBoard[index] = 'O';
      bool win = checkWinner("O");
      // score2 += 2;
      if (win) {
        score2 += 10;
        reset();
        // return  Text("${widget.playerTwoName}   أشطر كتكوووت");
      } else {
        counter++;
      }
    }
    if (counter == 9) {
      reset();
    }
    setState(() {});
  }
}
