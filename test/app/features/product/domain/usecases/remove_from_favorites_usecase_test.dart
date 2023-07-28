import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/repositories/favorite_repository.dart';
import 'package:fake_store/app/features/product/domain/usecases/params/favorites_params.dart';
import 'package:fake_store/app/features/product/domain/usecases/remove_from_favorites_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  late MockFavoriteRepository favoriteRepository;
  late RemoveFromFavoritesUsecase removeFromFavoritesUsecase;

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
    removeFromFavoritesUsecase = RemoveFromFavoritesUsecase(favoriteRepository);
    registerFallbackValue(product);
  });

  // remove test
  test('removeFromFavorites returns a list without the product', () async {
    //arrange
    when(() => favoriteRepository.removeFromFavorites(any()))
        .thenAnswer((_) async => const Right(null));

    //act
    await removeFromFavoritesUsecase(const FavoritesParams(product));

    //assert
    verify(() => favoriteRepository.removeFromFavorites(product)).called(1);
    verifyNoMoreInteractions(favoriteRepository);
  });

  test('removeFromFavorites returns a failure when there is a exception',
      () async {
    //arrange
    when(() => favoriteRepository.removeFromFavorites(any()))
        .thenAnswer((_) async => const Left(ServerFailure()));

    //act
    var result =
        await removeFromFavoritesUsecase(const FavoritesParams(product));

    //assert
    expect(result, const Left(ServerFailure()));
    verify(() => favoriteRepository.removeFromFavorites(product)).called(1);
    verifyNoMoreInteractions(favoriteRepository);
  });
}
