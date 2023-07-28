import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/exceptions.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/datasources/product_datasource.dart';
import 'package:fake_store/app/features/product/data/models/product_model.dart';
import 'package:fake_store/app/features/product/data/repositories/product_repository_impl.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductDataSource extends Mock implements ProductDataSource {}

void main() {
  late MockProductDataSource dataSource;
  late ProductRepositoryImpl repository;

  setUp(() {
    dataSource = MockProductDataSource();
    repository = ProductRepositoryImpl(dataSource);
  });

  group('ProductRepository Success', () {
    const product = ProductModel(
      id: 1,
      title: 'Product 1',
      price: Money(1.0),
      description: 'Description 1',
      category: 'Category 1',
      image: 'Image 1',
      rating: Rating(rate: 1, count: 1),
    );
    final products = [product];

    test('getProducts returns a list of products', () async {
      when(() => dataSource.getAll()).thenAnswer((_) async => products);

      final result = await repository.getAll();

      expect(result, Right(products));
      verify(() => dataSource.getAll()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('getProduct returns a product with the given id', () async {
      when(() => dataSource.get(any())).thenAnswer((_) async => product);

      final result = await repository.get(1);

      expect(result, const Right(product));
    });
  });

  group('ProductRepository Failure', () {
    test('getProducts returns a failure when an exception occurs', () async {
      when(() => dataSource.getAll()).thenThrow(ServerException());

      final result = await repository.getAll();

      expect(result, const Left(ServerFailure()));
      verify(() => dataSource.getAll()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('getProduct returns a failure when an exception occurs', () async {
      when(() => dataSource.get(any())).thenThrow(ServerException());

      final result = await repository.get(1);

      expect(result, const Left(ServerFailure()));
      verify(() => dataSource.get(any())).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
