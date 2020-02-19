import 'dart:math';

import 'field.dart';
import 'package:flutter/foundation.dart';

class Board { 
  final int rows;
  final int columns;
  final int quantityBombs;

  final List<Field> _fields = [];

  Board({
    @required this.rows,
    @required this.columns,
    @required this.quantityBombs,
  }) {
    _createFields();
    _relateNeighbors();  
    _drawMines();
  }

    restart() {
      _fields.forEach((f) => f.restart());
      _drawMines();
    }

    revealBombs() {
      _fields.forEach((f) => f.revealBomb());
    }
            
    _createFields() {
      for (int r = 0; r < rows; r++) {
        for (int c = 0; c < columns; c++) {
          _fields.add(Field(row: r, column: c));
        }
      }
    }

    _relateNeighbors() {
      for (var field in _fields) {
        for (var neighbor in _fields) {
          field.addNeighbor(neighbor);
        }
      }
    }

  _drawMines() {
    int drawn = 0;

    if (quantityBombs > rows * columns) {
      return;
    }

    while(drawn < quantityBombs) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].mined) {
        drawn++;
        _fields[i].mine();
      }
    }
  }

  List<Field> get fields => _fields;

  bool get solved => _fields.every((f) => f.solved);
}