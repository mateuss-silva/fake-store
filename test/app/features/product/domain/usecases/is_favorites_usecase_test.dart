import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/repositories/favorite_repository.dart';
import 'package:fake_store/app/features/product/domain/usecases/is_favorites_usecase.dart';
import 'package:fake_store/app/features/product/domain/usecases/params/favorites_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  late MockFavoriteRepository favoriteRepository;
  late IsFavoriteUsecase isFavoriteUsecase;

  const product = Product(
    id: 1,
    title: 'Product 1',
    price: Money(1),
    description: 'Description 1',
    category: 'Category 1',
    image: 'Image 1',
    rating: Rating(rate: 1, count: 1),
  );

  setUp(() {
    favoriteRepository = MockFavoriteRepository();
    isFavoriteUsecase = IsFavoriteUsecase(favoriteRepository);
    registerFallbackValue(product);
  });

  test('isFavorite returns true when product is favorite', () async {
    //arrange
    when(() => favoriteRepository.isFavorite(any()))
        .thenAnswer((_) async => const Right(true));

    //act
    var result = await isFavoriteUsecase(const FavoritesParams(product));

    //assert
    expect(result, const Right(true));
    verify(() => favoriteRepository.isFavorite(product)).called(1);
    verifyNoMoreInteractions(favoriteRepository);
  });

  test('isFavorite returns false when product is not favorite', () async {
    //arrange
    when(() => favoriteRepository.isFavorite(any()))
        .thenAnswer((_) async => const Right(false));

    //act
    var result = await isFavoriteUsecase(const FavoritesParams(product));

    //assert
    expect(result, const Right(false));
    verify(() => favoriteRepository.isFavorite(product)).called(1);
    verifyNoMoreInteractions(favoriteRepository);
  });

  test('isFavorite returns a failure when there is a exception', () async {
    //arrange
    when(() => favoriteRepository.isFavorite(any()))
        .thenAnswer((_) async => const Left(LocalStoreFailure()));

    //act
    var result = await isFavoriteUsecase(const FavoritesParams(product));

    //assert
    expect(result, const Left(LocalStoreFailure()));
    verify(() => favoriteRepository.isFavorite(product)).called(1);
    verifyNoMoreInteractions(favoriteRepository);
  });
}
