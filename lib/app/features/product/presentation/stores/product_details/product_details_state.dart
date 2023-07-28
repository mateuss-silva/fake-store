part of 'product_details_store.dart';

abstract base class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsIdleState extends ProductDetailsState {}

final class ProductDetailsLoadingState extends ProductDetailsState {}

final class ProductDetailsLoadedState extends ProductDetailsState {
  final Product product;

  const ProductDetailsLoadedState(this.product);

  @override
  List<Object> get props => [product];
}

final class ProductDetailsErrorState extends ProductDetailsState {
  final String message;

  const ProductDetailsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
