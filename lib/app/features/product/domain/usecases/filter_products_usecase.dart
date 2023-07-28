import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';

class FilterProductsUsecase
    implements Usecase<List<Product>, FilterProductsParams> {
  FilterProductsUsecase();

  @override
  Future<Either<Failure, List<Product>>> call(FilterProductsParams params) {
    return Future.value(
        Right(Product.filterByQuery(params.query, params.products)));
  }
}

final class FilterProductsParams extends BaseParams {
  final String query;
  final List<Product> products;

  const FilterProductsParams(this.query, this.products);

  @override
  List<Object> get props => [query, products];
}
