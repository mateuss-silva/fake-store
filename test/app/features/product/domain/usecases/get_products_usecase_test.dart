import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/core/usecase/params.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/repositories/product_repository.dart';
import 'package:fake_store/app/features/product/domain/usecases/get_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository productRepository;
  late GetProductsUsecase getProductUsecase;

  setUp(() {
    productRepository = MockProductRepository();
    getProductUsecase = GetProductsUsecase(productRepository);
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

  test('getProducts returns all products', () async {
    //arrange
    when(() => productRepository.getAll())
        .thenAnswer((_) async => Right(products));

    //act
    var result = await getProductUsecase(NoParams());

    //assert
    expect(result, Right(products));
    verify(() => productRepository.getAll()).called(1);
    verifyNoMoreInteractions(productRepository);
  });

  test('getProducts returns a failure when there is a exception', () async {
    //arrange
    when(() => productRepository.getAll())
        .thenAnswer((_) async => const Left(ServerFailure()));

    //act
    var result = await getProductUsecase(NoParams());

    //assert
    expect(result, const Left(ServerFailure()));
    verify(() => productRepository.getAll()).called(1);
    verifyNoMoreInteractions(productRepository);
  });
}
