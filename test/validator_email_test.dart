import 'package:cleanarch/utils/validator_email.dart';
import 'package:flutter_test/flutter_test.dart';

// unit test
void main() {
  test('validate for empty email id', () {
    // Arrange and Act
    var result = ValidatorEmail.validateEmail('');

    // assert
    expect(result, "Required Filed");
  });

  test('validate for invalid email id', () {
    // Arrange and Act
    var result = ValidatorEmail.validateEmail('sadsdasdsad');

    // assert
    expect(result, "Please Enter a valid email id");
  });

  test('validate for valid email id', () {
    // Arrange and Act
    var result = ValidatorEmail.validateEmail('ab@gmail.com');

    // assert
    expect(result, null);
  });
}
