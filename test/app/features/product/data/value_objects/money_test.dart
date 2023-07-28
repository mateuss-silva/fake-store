import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const money = Money(100);
  group('Money', () {
    test('Should be a class', () {
      expect(money, isA<Money>());
    });
    
  });
}
