import 'package:equatable/equatable.dart';
import 'package:fake_store/app/core/usecase/params.dart';
import 'package:fake_store/app/features/product/domain/usecases/get_favorites_usecase.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/usecases/add_to_favorites_usecase.dart';
import '../../../domain/usecases/is_favorites_usecase.dart';
import '../../../domain/usecases/params/favorites_params.dart';
import '../../../domain/usecases/remove_from_favorites_usecase.dart';

part 'favorites_state.dart';

class FavoritesStore extends ValueNotifier<FavoritesState> {
  final GetFavoritesUsecase _getFavoritesUsecase;
  final IsFavoriteUsecase _isFavoriteUsecase;

  final AddToFavoritesUsecase _addToFavoritesUsecase;
  final RemoveFromFavoritesUsecase _removeFromFavoritesUsecase;

  FavoritesStore(
    this._getFavoritesUsecase,
    this._isFavoriteUsecase,
    this._addToFavoritesUsecase,
    this._removeFromFavoritesUsecase,
  ) : super(FavoritesInitialState());

  Future<void> getFavorites() async {
    _updateFavoritesState(FavoritesLoadingState());
    final result = await _getFavoritesUsecase(NoParams());
    result.fold(
      (failure) => _updateFavoritesState(FavoritesErrorState(failure.message)),
      (products) => _updateFavoritesState(FavoritesLoadedState(products)),
    );
  }

  Future<bool> isFavorite(Product product) async {
    bool isFavorite = false;

    final result = await _isFavoriteUsecase(FavoritesParams(product));

    result.fold(
      (failure) => _updateFavoritesState(FavoritesErrorState(failure.message)),
      (favorite) => isFavorite = favorite,
    );

    return isFavorite;
  }

  Future<void> addToFavorites(Product product) async {
    final result = await _addToFavoritesUsecase(FavoritesParams(product));

    result.fold(
      (failure) => _updateFavoritesState(FavoritesErrorState(failure.message)),
      (success) => null,
    );
  }

  Future<void> removeFromFavorites(Product product) async {
    final result = await _removeFromFavoritesUsecase(FavoritesParams(product));

    result.fold(
      (failure) => _updateFavoritesState(FavoritesErrorState(failure.message)),
      (success) => null,
    );
  }

  void _updateFavoritesState(FavoritesState state) {
    value = state;
  }
}
