import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/core/usecase/params.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/usecases/filter_products_usecase.dart';
import 'package:fake_store/app/features/product/domain/usecases/get_products_usecase.dart';
import 'package:fake_store/app/features/product/presentation/stores/products/products_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProductsUsecase extends Mock implements GetProductsUsecase {}

class MockFilterProductsUseCase extends Mock implements FilterProductsUsecase {}

void main() {
  late ProductsStore productsStore;
  late MockGetProductsUsecase getProductsUsecase;
  late MockFilterProductsUseCase filterProductsUseCase;

  setUp(() {
    getProductsUsecase = MockGetProductsUsecase();
    filterProductsUseCase = MockFilterProductsUseCase();
    productsStore = ProductsStore(getProductsUsecase, filterProductsUseCase);

    registerFallbackValue(NoParams());
    registerFallbackValue(const FilterProductsParams('', []));
  });

  const products = [
    Product(
      id: 1,
      title: 'Product 1',
      price: Money(1),
      description: 'Description 1',
      category: 'Category 1',
      image: 'Image 1',
      rating: Rating(rate: 1, count: 1),
    ),
    Product(
      id: 2,
      title: 'Product 2',
      price: Money(2),
      description: 'Description 2',
      category: 'Category 2',
      image: 'Image 2',
      rating: Rating(rate: 2, count: 2),
    ),
  ];

  const filteredProducts = [
    Product(
      id: 1,
      title: 'Product 1',
      price: Money(1),
      description: 'Description 1',
      category: 'Category 1',
      image: 'Image 1',
      rating: Rating(rate: 1, count: 1),
    ),
  ];

  group('getProducts', () {
    test('should return products when getProductsUsecase returns products',
        () async {
      // arrange
      when(() => getProductsUsecase(any()))
          .thenAnswer((_) async => const Right(products));

      // act
      await productsStore.getProducts();

      // assert
      expect(
          productsStore.value, const ProductsLoadedState(products, products));
      verify(() => getProductsUsecase(NoParams())).called(1);
      verifyNoMoreInteractions(getProductsUsecase);
    });

    test('should return error when getProductsUsecase returns error', () async {
      // arrange
      when(() => getProductsUsecase(any()))
          .thenAnswer((_) async => const Left(ServerFailure()));

      // act
      await productsStore.getProducts();

      // assert
      expect(productsStore.value,
          ProductsErrorState(const ServerFailure().message));
    });
  });

  group('filterProducts', () {
    setUp(() {
      productsStore.value = const ProductsLoadedState(products, products);
    });
    test(
        'should return filtered products when filterProductsUseCase returns products',
        () async {
      // arrange
      when(() => filterProductsUseCase(any()))
          .thenAnswer((_) async => const Right(filteredProducts));

      // act
      await productsStore.searchProducts('Product 1');

      // assert
      expect(productsStore.value,
          const ProductsLoadedState(products, filteredProducts));
      verify(() => filterProductsUseCase(
          const FilterProductsParams('Product 1', products))).called(1);
      verifyNoMoreInteractions(filterProductsUseCase);
    });
  });
}
