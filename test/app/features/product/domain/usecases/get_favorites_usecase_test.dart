import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/core/usecase/params.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/repositories/favorite_repository.dart';
import 'package:fake_store/app/features/product/domain/usecases/get_favorites_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  late MockFavoriteRepository favoriteRepository;
  late GetFavoritesUsecase getFavoritesUsecase;

  setUp(() {
    favoriteRepository = MockFavoriteRepository();
    getFavoritesUsecase = GetFavoritesUsecase(favoriteRepository);
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

  test('getFavorites returns all favorites', () async {
    //arrange
    when(() => favoriteRepository.getAll())
        .thenAnswer((_) async => Right(products));

    //act
    var result = await getFavoritesUsecase(NoParams());

    //assert
    expect(result, Right(products));
    verify(() => favoriteRepository.getAll()).called(1);
    verifyNoMoreInteractions(favoriteRepository);
  });

  test('getFavorites returns a failure when there is a local failure',
      () async {
    //arrange
    when(() => favoriteRepository.getAll())
        .thenAnswer((_) async => const Left(LocalStoreFailure()));

    //act
    var result = await getFavoritesUsecase(NoParams());

    //assert
    expect(result, const Left(LocalStoreFailure()));
    verify(() => favoriteRepository.getAll()).called(1);
    verifyNoMoreInteractions(favoriteRepository);
  });
}
