import 'package:flutter_test/flutter_test.dart';
import 'package:minefield_app/models/field.dart';

main() {

  group('Field', () {
    
    test('Open a field with explosion', () {
      Field field = Field(row: 0, column: 0);
      field.mine();
      
      expect(field.open, throwsException);
    });

    test('Open a field without explosion', () {
      Field field = Field(row: 0, column: 0);
      field.open();
      
      expect(field.opened, isTrue);
    });

    test('Add not neighbor', () {
      Field field1 = Field(row: 0, column: 0);
      Field field2 = Field(row: 0, column: 0);
      field1.addNeighbor(field2);
      expect(field1.neighbors.isEmpty, isTrue);
    });

    test('Add neighbor', () {
      Field field1 = Field(row: 3, column: 3);
      Field field2 = Field(row: 3, column: 4);
      Field field3 = Field(row: 2, column: 2);
      Field field4 = Field(row: 4, column: 4);
      field1.addNeighbor(field2);
      field1.addNeighbor(field3);
      field1.addNeighbor(field4);
      expect(field1.neighbors.length, 3);
    });

    test('Mines on neighborhood', () {
      Field field1 = Field(row: 3, column: 3);

      Field field2 = Field(row: 3, column: 4);
      field2.mine();

      Field field3 = Field(row: 2, column: 2);
      
      Field field4 = Field(row: 4, column: 4);
      field4.mine();

      field1.addNeighbor(field2);
      field1.addNeighbor(field3);
      field1.addNeighbor(field4);
      expect(field1.quantityMinesOnNeighborhood, 2);
    });
  });
}