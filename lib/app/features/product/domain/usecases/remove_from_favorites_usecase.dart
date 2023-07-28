import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/favorite_repository.dart';
import 'params/favorites_params.dart';

class RemoveFromFavoritesUsecase implements Usecase<void, FavoritesParams> {
  final FavoriteRepository _favoritesRepository;

  RemoveFromFavoritesUsecase(this._favoritesRepository);

  @override
  Future<Either<Failure, void>> call(FavoritesParams params) async {
    return await _favoritesRepository.removeFromFavorites(params.product);
  }
}
