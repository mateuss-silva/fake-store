import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Product>>> getAll() async {
    try {
      final products = await datasource.getAll();
      return Right(products);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> get(int id) async {
    try {
      final product = await datasource.get(id);
      return Right(product);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
