import 'package:cleanarch/utils/maths_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('check for two number addition', () {

    // Arrange
    var a = 10;
    var b = 10;

    // Act
    var sum = add(a, b);

    // Assert
    expect(sum, 20);
  });
}
