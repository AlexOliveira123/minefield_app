import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';


class Field {
  final int row;
  final int column;
  final List<Field> neighbors = [];

  bool _isOpened = false;
  bool _isMarked = false;
  bool _isMined = false;
  bool _isExploded = false;

  Field({
    @required this.row,
    @required this.column,
  });

  addNeighbor(Field neighbor){
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  open() {
    if (_isOpened) {
      return;
    }

    _isOpened = true;

    if (_isMined) {
      _isExploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbors.forEach((neighbor) => neighbor.open());
    }
  }

  revealBomb() {
    if (_isMined) {
      _isOpened = true;
    }
  }

  mine() {
    _isMined = true;
  }

  toggleMarking() {
    _isMarked = !_isMarked;
  }

  restart() {
    _isOpened = false; 
    _isMarked = false;
    _isMined = false;
    _isExploded = false;    
  }

  bool get exploded => _isExploded;

  bool get mined => _isMined;

  bool get opened => _isOpened;

  bool get marked => _isMarked;

  bool get solved {
    bool minedAndMarked = mined && marked;
    bool safeAndOpened = !mined && opened;

    return minedAndMarked || safeAndOpened;
  }

  bool get safeNeighborhood => neighbors.every((neighbor) => !neighbor._isMined);

  int get quantityMinesOnNeighborhood => neighbors.where((neighbor) => neighbor.mined).length;
}