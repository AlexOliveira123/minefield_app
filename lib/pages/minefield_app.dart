import 'package:flutter/material.dart';
import 'package:minefield_app/components/board_widget.dart';
import 'package:minefield_app/models/board.dart';
import 'package:minefield_app/models/explosion_exception.dart';
import 'package:minefield_app/models/field.dart';
import '../components/result_widget.dart';

class MinefieldApp extends StatefulWidget {
  @override
  _MinefieldAppState createState() => _MinefieldAppState();
}

class _MinefieldAppState extends State<MinefieldApp> {  
  bool _won;
  Board _board;

  _restart() {
    setState(() {
      _won = null;
      _board.restart();
    });
  }

  _open(Field field) {
    if (_won != null) {
      return;
    }

    setState(() {
      try {
        field.open();
        if (_board.solved) {
          _won = true;
        }
      } on ExplosionException {
        _won = false;
        _board.revealBombs();
      }
    });
  }

  _toggleMarking(Field field) {
    if (_won != null) {
      return;
    }

    setState(() {
      field.toggleMarking();
      if (_board.solved) {
        _won = true;
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (_board == null) {
      int qttColumns = 15;
      double fieldSize = width / qttColumns;
      int qttLines = (height / fieldSize).floor();

      _board = Board(rows: qttLines, columns: qttColumns, quantityBombs: 50);
    }

    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultWidget(won: _won, onRestart: _restart,),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board: _getBoard(constraints.maxWidth, constraints.maxHeight),
                onOpen: _open,
                onToggleMarking: _toggleMarking,
              );
            },
          ),
        ),
      ),
    );
  }
}