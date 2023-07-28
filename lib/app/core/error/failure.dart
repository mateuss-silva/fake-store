import 'package:equatable/equatable.dart';

abstract base class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure() : super("Something went wrong!");
}

final class LocalStoreFailure extends Failure {
  const LocalStoreFailure() : super("something went wrong locally!");
}
