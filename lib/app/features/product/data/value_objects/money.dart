import '../../../../core/value_objects/value_object.dart';

final class Money extends ValueObject {
  final double price;

  const Money(this.price);

  String get usd => '\$${price.toStringAsFixed(2)}';

  @override
  String toString() => price.toString();

  @override
  List<Object> get props => [price];
}
