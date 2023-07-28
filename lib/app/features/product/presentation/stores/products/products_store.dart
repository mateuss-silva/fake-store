import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/usecase/params.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/filter_products_usecase.dart';
import '../../../domain/usecases/get_products_usecase.dart';

part 'products_state.dart';

class ProductsStore extends ValueNotifier<ProductsState> {
  final GetProductsUsecase _getProductsUsecase;
  final FilterProductsUsecase _filterProductsUsecase;
  ProductsStore(this._getProductsUsecase, this._filterProductsUsecase)
      : super(ProductsIdleState());

  Future<void> searchProducts(String query) async {
    final currentState = value;
    if (currentState is ProductsLoadedState) {
      _updateFilteredProducts(
        await _filterProductsUsecase(
            FilterProductsParams(query, currentState.products)),
        currentState.products,
      );
    }
  }

  Future<void> getProducts() async {
    _updateProductsState(ProductsLoadingState());

    _updateLoadedProducts(await _getProductsUsecase(NoParams()));
  }

  void _updateFilteredProducts(result, allProducts) {
    result.fold(
      (failure) => _updateProductsState(ProductsErrorState(failure.message)),
      (filteredProducts) => _updateProductsState(
          ProductsLoadedState(allProducts, filteredProducts)),
    );
  }

  void _updateLoadedProducts(result) {
    result.fold(
      (failure) => _updateProductsState(ProductsErrorState(failure.message)),
      (products) =>
          _updateProductsState(ProductsLoadedState(products, products)),
    );
  }

  void _updateProductsState(ProductsState state) {
    value = state;
  }
}
