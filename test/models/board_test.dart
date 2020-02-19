import 'package:flutter_test/flutter_test.dart';
import 'package:minefield_app/models/board.dart';

main() {

  test('Win the game', (){
    Board board = Board(
      rows: 2,
      columns: 2,
      quantityBombs: 0,
    );

    board.fields[0].mine();
    board.fields[3].mine();

    board.fields[0].toggleMarking();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].toggleMarking();

    expect(board.solved, isTrue);
  });
}