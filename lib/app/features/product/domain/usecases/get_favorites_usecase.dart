import 'package:dartz/dartz.dart';

import 'package:fake_store/app/core/error/failure.dart';

import '../../../../core/usecase/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/favorite_repository.dart';

class GetFavoritesUsecase implements Usecase<List<Product>, NoParams> {
  final FavoriteRepository favoriteRepository;

  GetFavoritesUsecase(this.favoriteRepository);
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return favoriteRepository.getAll();
  }
}
