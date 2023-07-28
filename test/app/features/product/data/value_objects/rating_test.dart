import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Rating', () {
    const rating = Rating(count: 10, rate: 5.6);

    test('is a class', () {
      expect(rating, isA<Rating>());
    });

    test('Rating from Json', () {
      final json = {
        'rate': 5.6,
        'count': 10,
      };

      var result = Rating.fromJson(json);

      expect(result, rating);
    });

    test('toString', () {
      expect(rating.toString(), '${rating.rate} (${rating.count} reviews)');
    });
  });
}
