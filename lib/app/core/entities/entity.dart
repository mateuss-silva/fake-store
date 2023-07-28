import 'package:equatable/equatable.dart';

abstract base class Entity extends Equatable {
  final int id;

  const Entity({required this.id});

  @override
  List<Object> get props => [id];
}
