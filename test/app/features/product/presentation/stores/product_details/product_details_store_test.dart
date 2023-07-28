import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/usecases/get_product_usecase.dart';
import 'package:fake_store/app/features/product/presentation/stores/product_details/product_details_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProductUsecase extends Mock implements GetProductUsecase {}

void main() {
  late ProductDetailsStore productDetailsStore;
  late MockGetProductUsecase getProductUsecase;

  setUp(() {
    getProductUsecase = MockGetProductUsecase();
    productDetailsStore = ProductDetailsStore(getProductUsecase);
    registerFallbackValue(const GetProductParams(1));
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

  group('getProduct', () {
    test('should return product when getProductUsecase returns product',
        () async {
      // arrange
      when(() => getProductUsecase(any()))
          .thenAnswer((_) async => const Right(product));

      // act
      await productDetailsStore.getProduct(1);

      // assert
      expect(
          productDetailsStore.value, const ProductDetailsLoadedState(product));
      verify(() => getProductUsecase(const GetProductParams(1))).called(1);
      verifyNoMoreInteractions(getProductUsecase);
    });

    test('should return error when getProductUsecase returns error', () async {
      // arrange
      when(() => getProductUsecase(any()))
          .thenAnswer((_) async => const Left(ServerFailure()));

      // act
      await productDetailsStore.getProduct(1);

      // assert
      expect(productDetailsStore.value,
          ProductDetailsErrorState(const ServerFailure().message));
      verify(() => getProductUsecase(const GetProductParams(1))).called(1);
      verifyNoMoreInteractions(getProductUsecase);
    });
  });
}
