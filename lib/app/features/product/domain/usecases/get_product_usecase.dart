import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductUsecase implements Usecase<Product, GetProductParams> {
  final ProductRepository repository;

  GetProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(GetProductParams params) {
    return repository.get(params.id);
  }
}

final class GetProductParams extends BaseParams {
  final int id;

  const GetProductParams(this.id);

  @override
  List<Object> get props => [id];
}
