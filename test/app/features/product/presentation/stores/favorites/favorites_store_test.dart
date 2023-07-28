import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/core/usecase/params.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/usecases/add_to_favorites_usecase.dart';
import 'package:fake_store/app/features/product/domain/usecases/get_favorites_usecase.dart';
import 'package:fake_store/app/features/product/domain/usecases/is_favorites_usecase.dart';
import 'package:fake_store/app/features/product/domain/usecases/params/favorites_params.dart';
import 'package:fake_store/app/features/product/domain/usecases/remove_from_favorites_usecase.dart';
import 'package:fake_store/app/features/product/presentation/stores/favorites/favorites_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetFavoritesUsecase extends Mock implements GetFavoritesUsecase {}

class MockIsFavoriteUsecase extends Mock implements IsFavoriteUsecase {}

class MockAddToFavoritesUsecase extends Mock implements AddToFavoritesUsecase {}

class MockRemoveFromFavoritesUsecase extends Mock
    implements RemoveFromFavoritesUsecase {}

void main() {
  late FavoritesStore favoritesStore;

  late MockGetFavoritesUsecase getFavoritesUsecase;
  late MockIsFavoriteUsecase isFavoriteUsecase;
  late MockAddToFavoritesUsecase addToFavoritesUsecase;
  late MockRemoveFromFavoritesUsecase removeFromFavoritesUsecase;

  final favorites = [
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

  setUp(() {
    getFavoritesUsecase = MockGetFavoritesUsecase();
    isFavoriteUsecase = MockIsFavoriteUsecase();
    addToFavoritesUsecase = MockAddToFavoritesUsecase();
    removeFromFavoritesUsecase = MockRemoveFromFavoritesUsecase();

    favoritesStore = FavoritesStore(
      getFavoritesUsecase,
      isFavoriteUsecase,
      addToFavoritesUsecase,
      removeFromFavoritesUsecase,
    );
    registerFallbackValue(NoParams());
    registerFallbackValue(FavoritesParams(favorites.first));
  });

  group('getFavorites', () {
    test('getFavorites returns a list of products favorites', () async {
      //arrange
      when(() => getFavoritesUsecase(any()))
          .thenAnswer((_) async => Right(favorites));

      //act
      await favoritesStore.getFavorites();

      //assert
      expect(favoritesStore.value, FavoritesLoadedState(favorites));
      verify(() => getFavoritesUsecase(NoParams())).called(1);
      verifyNoMoreInteractions(getFavoritesUsecase);
    });

    test('getFavorites returns a error when there is a exception', () async {
      //arrange
      when(() => getFavoritesUsecase(any()))
          .thenAnswer((_) async => const Left(LocalStoreFailure()));

      //act
      await favoritesStore.getFavorites();

      //assert
      expect(favoritesStore.value,
          FavoritesErrorState(const LocalStoreFailure().message));
      verify(() => getFavoritesUsecase(NoParams())).called(1);
      verifyNoMoreInteractions(getFavoritesUsecase);
    });
  });

  group('isFavorite', () {
    test('isFavorite returns true when the product is favorite', () async {
      //arrange
      when(() => isFavoriteUsecase(any()))
          .thenAnswer((_) async => const Right(true));

      //act
      var result = await favoritesStore.isFavorite(favorites.first);

      //assert
      expect(result, true);
      verify(() => isFavoriteUsecase(FavoritesParams(favorites.first)))
          .called(1);
      verifyNoMoreInteractions(isFavoriteUsecase);
    });

    test('isFavorite returns false when the product is not favorite', () async {
      //arrange
      when(() => isFavoriteUsecase(any()))
          .thenAnswer((_) async => const Right(false));

      //act
      var result = await favoritesStore.isFavorite(favorites.first);

      //assert
      expect(result, false);
      verify(() => isFavoriteUsecase(FavoritesParams(favorites.first)))
          .called(1);
      verifyNoMoreInteractions(isFavoriteUsecase);
    });

    test('isFavorite returns a error when there is a exception', () async {
      //arrange
      when(() => isFavoriteUsecase(any()))
          .thenAnswer((_) async => const Left(LocalStoreFailure()));

      //act
      await favoritesStore.isFavorite(favorites.first);

      //assert
      expect(favoritesStore.value,
          FavoritesErrorState(const LocalStoreFailure().message));
      verify(() => isFavoriteUsecase(FavoritesParams(favorites.first)))
          .called(1);
      verifyNoMoreInteractions(isFavoriteUsecase);
    });
  });

  group('addToFavorites', () {
    test('addToFavorites returns a list with the product', () async {
      //arrange
      when(() => addToFavoritesUsecase(any()))
          .thenAnswer((_) async => const Right(null));

      //act
      await favoritesStore.addToFavorites(favorites.first);

      //assert
      verify(() => addToFavoritesUsecase(FavoritesParams(favorites.first)))
          .called(1);
      verifyNoMoreInteractions(addToFavoritesUsecase);
    });

    test('addToFavorites returns a error when there is a exception', () async {
      //arrange
      when(() => addToFavoritesUsecase(any()))
          .thenAnswer((_) async => const Left(LocalStoreFailure()));

      //act
      await favoritesStore.addToFavorites(favorites.first);

      //assert
      expect(favoritesStore.value,
          FavoritesErrorState(const LocalStoreFailure().message));
      verify(() => addToFavoritesUsecase(FavoritesParams(favorites.first)))
          .called(1);
      verifyNoMoreInteractions(addToFavoritesUsecase);
    });
  });

  group('removeFromFavorites', () {
    test('removeFromFavorites returns a list without the product', () async {
      //arrange
      when(() => removeFromFavoritesUsecase(any()))
          .thenAnswer((_) async => const Right(null));

      //act
      await favoritesStore.removeFromFavorites(favorites.first);

      //assert
      verify(() => removeFromFavoritesUsecase(FavoritesParams(favorites.first)))
          .called(1);
      verifyNoMoreInteractions(removeFromFavoritesUsecase);
    });

    test('removeFromFavorites returns a error when there is a exception',
        () async {
      //arrange
      when(() => removeFromFavoritesUsecase(any()))
          .thenAnswer((_) async => const Left(LocalStoreFailure()));

      //act
      await favoritesStore.removeFromFavorites(favorites.first);

      //assert
      expect(favoritesStore.value,
          FavoritesErrorState(const LocalStoreFailure().message));
      verify(() => removeFromFavoritesUsecase(FavoritesParams(favorites.first)))
          .called(1);
      verifyNoMoreInteractions(removeFromFavoritesUsecase);
    });
  });
}
