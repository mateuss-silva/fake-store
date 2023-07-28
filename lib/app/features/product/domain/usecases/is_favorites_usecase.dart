import 'package:dartz/dartz.dart';

import 'package:fake_store/app/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/favorite_repository.dart';
import 'params/favorites_params.dart';

class IsFavoriteUsecase implements Usecase<bool, FavoritesParams> {
  final FavoriteRepository favoriteRepository;

  IsFavoriteUsecase(this.favoriteRepository);
  @override
  Future<Either<Failure, bool>> call(FavoritesParams params) {
    return favoriteRepository.isFavorite(params.product);
  }
}
