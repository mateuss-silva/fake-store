import 'package:equatable/equatable.dart';

abstract base class BaseParams extends Equatable {
  const BaseParams();
}

final class NoParams extends BaseParams {
  @override
  List<Object?> get props => [];
}
