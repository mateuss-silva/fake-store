part of 'favorites_store.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitialState extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesLoadedState extends FavoritesState {
  final List<Product> products;

  const FavoritesLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

class FavoritesErrorState extends FavoritesState {
  final String message;

  const FavoritesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
