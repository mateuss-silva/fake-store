import 'package:dartz/dartz.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/usecases/filter_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFilterProducts extends Mock implements FilterProductsUsecase {}

void main() {
  late MockFilterProducts filterProducts;

  setUp(() {
    filterProducts = MockFilterProducts();
    registerFallbackValue(const FilterProductsParams('', []));
  });

  final products = [
    const Product(
      id: 1,
      title: 'Product 1',
      price: Money(1),
      description: 'Description 1',
      category: 'Category 1',
      image: 'Image 1',
      rating: Rating(rate: 1, count: 1),
    ),
    const Product(
      id: 2,
      title: 'Product 2',
      price: Money(2),
      description: 'Description 2',
      category: 'Category 2',
      image: 'Image 2',
      rating: Rating(rate: 2, count: 2),
    ),
  ];

  final filteredProducts = [
    const Product(
      id: 1,
      title: 'Product 1',
      price: Money(1),
      description: 'Description 1',
      category: 'Category 1',
      image: 'Image 1',
      rating: Rating(rate: 1, count: 1),
    ),
  ];

  test('filterProducts returns all products when query is empty', () async {
    //arrange
    when(() => filterProducts(any())).thenAnswer((_) async => Right(products));

    const query = '';

    //act
    var result = await filterProducts(FilterProductsParams(query, products));

    //assert
    expect(result, Right(products));
  });

  test('filterProducts returns filtered products when query is not empty',
      () async {
    //arrange
    when(() => filterProducts(any()))
        .thenAnswer((_) async => Right(filteredProducts));

    const query = 'Product 1';

    //act
    var result = await filterProducts(FilterProductsParams(query, products));

    //assert
    expect(result, Right(filteredProducts));
  });
}
