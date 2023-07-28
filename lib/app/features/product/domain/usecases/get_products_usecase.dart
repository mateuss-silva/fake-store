import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUsecase implements Usecase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getAll();
  }
}
