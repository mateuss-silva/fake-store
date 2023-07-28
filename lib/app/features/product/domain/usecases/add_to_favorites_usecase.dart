import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/favorite_repository.dart';
import 'params/favorites_params.dart';

class AddToFavoritesUsecase implements Usecase<void, FavoritesParams> {
  final FavoriteRepository repository;

  AddToFavoritesUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(FavoritesParams params) async {
    return await repository.addToFavorites(params.product);
  }
}
