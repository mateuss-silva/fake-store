import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final products = [
    const Product(
        id: 1,
        title: 'Product 1',
        price: Money(1),
        description: 'Description 1',
        category: 'Category 1',
        image: 'Image 1',
        rating: Rating(rate: 1, count: 1)),
    const Product(
        id: 2,
        title: 'Product 2',
        price: Money(2),
        description: 'Description 2',
        category: 'Category 2',
        image: 'Image 2',
        rating: Rating(rate: 2, count: 2)),
    const Product(
        id: 3,
        title: 'Product 3',
        price: Money(3),
        description: 'Description 3',
        category: 'Category 3',
        image: 'Image 3',
        rating: Rating(rate: 3, count: 3)),
  ];

  test('filterByQuery returns products that match the query', () {
    //act
    final result = Product.filterByQuery('Product 2', products);

    expect(result, equals([products[1]]));
  });
}
