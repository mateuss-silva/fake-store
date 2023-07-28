import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<Product>>> getAll();

  Future<Either<Failure, Product>> get(int id);
}
