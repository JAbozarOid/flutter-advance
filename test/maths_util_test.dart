import 'package:cleanarch/utils/maths_util.dart';
import 'package:flutter_test/flutter_test.dart';

// unit test
void main() {
  // all test function in a one class can goes in group
  group('Maths utils -', () {
    test('check for two number addition', () {
      // Arrange
      var a = 10;
      var b = 10;

      // Act
      var sum = add(a, b);

      // Assert
      expect(sum, 20);
    });

    test('check for two number substraction', () {
      // Arrange
      var a = 10;
      var b = 10;

      // Act
      var subs = substract(a, b);

      // Assert
      expect(subs, 0);
    });

    test('check for two number multiply', () {
      // Arrange
      var a = 10;
      var b = 10;

      // Act
      var mul = multiply(a, b);

      // Assert
      expect(mul, 100);
    });
  });
}
