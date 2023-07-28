import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/datasources/favorite_local_datasource.dart';
import 'package:fake_store/app/features/product/data/models/product_model.dart';
import 'package:fake_store/app/features/product/data/repositories/favorite_repository_impl.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteDataSource extends Mock implements FavoriteLocalDataSource {}

void main() {
  late MockFavoriteDataSource dataSource;
  late FavoriteRepositoryImpl repository;

  const favorite = ProductModel(
    id: 1,
    title: 'Product 1',
    price: Money(1.0),
    description: 'Description 1',
    category: 'Category 1',
    image: 'Image 1',
    rating: Rating(rate: 1, count: 1),
  );

  setUp(() {
    dataSource = MockFavoriteDataSource();
    repository = FavoriteRepositoryImpl(dataSource);
    registerFallbackValue(favorite);
  });

  final favorites = [favorite];

  group('FavoriteRepository success', () {
    test('getAll returns a list of favorites products', () async {
      when(() => dataSource.getAll()).thenAnswer((_) async => favorites);

      final result = await repository.getAll();

      expect(result, Right(favorites));
      verify(() => dataSource.getAll()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('addToFavorites adds a favorite to the list', () async {
      when(() => dataSource.add(any())).thenAnswer((_) async {});

      final result = await repository.addToFavorites(favorite);

      expect(result, const Right(null));
      verify(() => dataSource.add(favorite)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('removeFromFavorites removes a product from the favorites', () async {
      when(() => dataSource.remove(favorite)).thenAnswer((_) async => {});

      final result = await repository.removeFromFavorites(favorite);

      expect(result, const Right(null));
      verify(() => dataSource.remove(favorite)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('isFavorite returns true when product is in favorites', () async {
      when(() => dataSource.isFavorite(any())).thenAnswer((_) async => true);

      final result = await repository.isFavorite(favorite);

      expect(result, const Right(true));
      verify(() => dataSource.isFavorite(favorite)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('FavoriteRepository failure', () {
    test('getAll returns a failure when dataSource fails', () async {
      when(() => dataSource.getAll()).thenThrow(Exception());

      final result = await repository.getAll();

      expect(result, const Left(LocalStoreFailure()));
      verify(() => dataSource.getAll()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('addToFavorites returns a failure when dataSource fails', () async {
      when(() => dataSource.add(any())).thenThrow(Exception());

      final result = await repository.addToFavorites(favorite);

      expect(result, const Left(LocalStoreFailure()));
      verify(() => dataSource.add(favorite)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('removeFromFavorites returns a failure when dataSource fails',
        () async {
      when(() => dataSource.remove(any())).thenThrow(Exception());

      final result = await repository.removeFromFavorites(favorite);

      expect(result, const Left(LocalStoreFailure()));
      verify(() => dataSource.remove(favorite)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('isFavorite returns a failure when dataSource fails', () async {
      when(() => dataSource.isFavorite(any())).thenThrow(Exception());

      final result = await repository.isFavorite(favorite);

      expect(result, const Left(LocalStoreFailure()));
      verify(() => dataSource.isFavorite(favorite)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
