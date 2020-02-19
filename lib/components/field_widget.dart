import 'package:flutter/material.dart';
import 'package:minefield_app/models/field.dart';

class FieldWidget extends StatelessWidget {

  final Field field;
  final Function(Field) onOpen;
  final Function(Field) onToggleMarking;

  FieldWidget({
    @required this.field,
    @required this.onOpen,
    @required this.onToggleMarking
  });

  Widget _getImage() {
    int qttMines = field.quantityMinesOnNeighborhood;

    if (field.opened && field.mined && field.exploded) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (field.opened && field.mined) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (field.opened && qttMines > 0) {
      return Image.asset('assets/images/open_$qttMines.jpeg');
    } else if (field.opened) {
      return Image.asset('assets/images/open_0.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/flag.jpeg');
    } else {
      return Image.asset('assets/images/closed.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onToggleMarking(field),
      child: _getImage(),
    );
  }
}