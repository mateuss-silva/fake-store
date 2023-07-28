import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_product_usecase.dart';

part 'product_details_state.dart';

class ProductDetailsStore extends ValueNotifier<ProductDetailsState> {
  final GetProductUsecase _getProductUsecase;
  ProductDetailsStore(this._getProductUsecase)
      : super(ProductDetailsIdleState());

  void init(Product product) {
    value = ProductDetailsLoadedState(product);
  }

  Future<void> getProduct(int id) async {
    _updateProductState(ProductDetailsLoadingState());

    _updateProductUsecase(await _getProductUsecase(GetProductParams(id)));
  }

  void _updateProductUsecase(result) {
    result.fold(
      (failure) =>
          _updateProductState(ProductDetailsErrorState(failure.message)),
      (products) => _updateProductState(ProductDetailsLoadedState(products)),
    );
  }

  void _updateProductState(ProductDetailsState state) {
    value = state;
  }
}
