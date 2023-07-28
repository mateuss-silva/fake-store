import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';
import 'package:fake_store/app/features/product/data/models/product_model.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/domain/repositories/favorite_repository.dart';

import '../datasources/favorite_local_datasource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource _favoriteLocalDataSource;

  FavoriteRepositoryImpl(this._favoriteLocalDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAll() async {
    try {
      final products = await _favoriteLocalDataSource.getAll();
      return Right(products);
    } catch (e) {
      return const Left(LocalStoreFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(Product product) async {
    try {
      final isFavorite = await _favoriteLocalDataSource
          .isFavorite(ProductModel.fromEntity(product));

      return Right(isFavorite);
    } catch (e) {
      return const Left(LocalStoreFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(Product product) async {
    try {
      await _favoriteLocalDataSource.add(ProductModel.fromEntity(product));
      return const Right(null);
    } catch (e) {
      return const Left(LocalStoreFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(Product product) async {
    try {
      await _favoriteLocalDataSource.remove(ProductModel.fromEntity(product));
      return const Right(null);
    } catch (e) {
      return const Left(LocalStoreFailure());
    }
  }
}
