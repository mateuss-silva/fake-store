part of 'products_store.dart';

abstract base class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsIdleState extends ProductsState {}

final class ProductsLoadingState extends ProductsState {}

final class ProductsLoadedState extends ProductsState {
  final List<Product> products;
  final List<Product> filteredProducts;

  const ProductsLoadedState(this.products, this.filteredProducts);

  @override
  List<Object> get props => [products, filteredProducts];
}

final class ProductsErrorState extends ProductsState {
  final String message;

  const ProductsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
