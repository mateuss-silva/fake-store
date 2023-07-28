import 'package:dartz/dartz.dart';
import 'package:fake_store/app/core/error/failure.dart';

abstract interface class Usecase<Entity, Params> {
  Future<Either<Failure, Entity>> call(Params params);
}
