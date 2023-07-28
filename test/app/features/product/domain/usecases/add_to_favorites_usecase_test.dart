import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/repositories/favorite_repository.dart';
import 'package:fake_store/app/features/product/domain/usecases/add_to_favorites_usecase.dart';
import 'package:fake_store/app/features/product/domain/usecases/params/favorites_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  late AddToFavoritesUsecase addToFavorites;
  late MockFavoriteRepository repository;

  const product = Product(
      id: 1,
      title: 'Product 1',
      price: Money(1),
      description: 'Description 1',
      category: 'Category 1',
      image: 'Image 1',
      rating: Rating(rate: 1, count: 1));

  setUp(() {
    repository = MockFavoriteRepository();
    addToFavorites = AddToFavoritesUsecase(repository);
    registerFallbackValue(product);
  });

  test('addToFavorites calls repository', () async {
    //arrange
    when(() => repository.addToFavorites(any()))
        .thenAnswer((_) async => const Right(null));

    //act
    var result = await addToFavorites(const FavoritesParams(product));

    //assert
    expect(result, const Right(null));
    verify(() => repository.addToFavorites(product)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('addToFavorites returns Left when repository fails', () async {
    //arrange
    when(() => repository.addToFavorites(any()))
        .thenAnswer((_) async => const Left(ServerFailure()));

    //act
    var result = await addToFavorites(const FavoritesParams(product));

    //assert
    expect(result, const Left(ServerFailure()));
    verify(() => repository.addToFavorites(product)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
