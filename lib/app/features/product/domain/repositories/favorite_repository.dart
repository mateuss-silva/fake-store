import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Product>>> getAll();

  Future<Either<Failure, bool>> isFavorite(Product product);

  Future<Either<Failure, void>> addToFavorites(Product product);

  Future<Either<Failure, void>> removeFromFavorites(Product product);
}
