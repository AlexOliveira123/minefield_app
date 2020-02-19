import 'package:flutter/material.dart';
import 'package:minefield_app/components/field_widget.dart';
import 'package:minefield_app/models/board.dart';
import 'package:minefield_app/models/field.dart';

class BoardWidget extends StatelessWidget {

  final Board board;
  final Function(Field) onOpen;
  final Function(Field) onToggleMarking;

  BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onToggleMarking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((field){
          return FieldWidget(
            field: field,
            onOpen: onOpen,
            onToggleMarking: onToggleMarking,
          );
        }).toList(),
      ),
    );
  }
}