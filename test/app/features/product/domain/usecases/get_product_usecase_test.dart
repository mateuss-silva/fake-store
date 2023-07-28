import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/repositories/product_repository.dart';
import 'package:fake_store/app/features/product/domain/usecases/get_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository productRepository;
  late GetProductUsecase getProductUsecase;

  setUp(() {
    productRepository = MockProductRepository();
    getProductUsecase = GetProductUsecase(productRepository);
  });

  const product = Product(
    id: 1,
    title: 'Product 1',
    price: Money(1),
    description: 'Description 1',
    category: 'Category 1',
    image: 'Image 1',
    rating: Rating(rate: 1, count: 1),
  );

  test('getProduct returns a product', () async {
    //arrange
    when(() => productRepository.get(any()))
        .thenAnswer((_) async => const Right(product));

    //act
    var result = await getProductUsecase(const GetProductParams(1));

    //assert
    expect(result, const Right(product));
    verify(() => productRepository.get(1)).called(1);
    verifyNoMoreInteractions(productRepository);
  });

  test('getProduct returns a failure when there is a exception', () async {
    //arrange
    when(() => productRepository.get(any()))
        .thenAnswer((_) async => const Left(ServerFailure()));

    //act
    var result = await getProductUsecase(const GetProductParams(1));

    //assert
    expect(result, const Left(ServerFailure()));
    verify(() => productRepository.get(1)).called(1);
    verifyNoMoreInteractions(productRepository);
  });
}
