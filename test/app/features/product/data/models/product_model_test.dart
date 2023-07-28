import 'package:fake_store/app/features/product/data/models/product_model.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProductModel = ProductModel(
    id: 1,
    title: 'title',
    price: Money(1),
    description: 'description',
    category: 'category',
    image: 'image',
    rating: Rating(rate: 1, count: 1),
  );

  group('fromJson', () {
    test('should be a subclass of Product entity', () async {
      // assert
      expect(tProductModel, isA<Product>());
    });

    test('should return a valid model when the JSON is valid', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "title": "title",
        "price": 1,
        "description": "description",
        "category": "category",
        "image": "image",
        "rating": {"rate": 1, "count": 1}
      };
      // act
      final result = ProductModel.fromJson(jsonMap);
      // assert
      expect(result, tProductModel);
    });

    test('toJson', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "title": "title",
        "price": 1.0,
        "description": "description",
        "category": "category",
        "image": "image",
        "rating": {"rate": 1.0, "count": 1}
      };

      // act
      final result = tProductModel.toJson();

      // assert
      expect(result, jsonMap);
    });
  });
}
