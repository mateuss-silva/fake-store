import '../../../../core/common/types.dart';
import '../../../../core/value_objects/value_object.dart';

final class Rating extends ValueObject {
  final double rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Json json) => Rating(
        rate: json['rate'].toDouble(),
        count: json['count'].toInt(),
      );

  Json toJson() => {
        'rate': rate,
        'count': count,
      };

  @override
  List<Object> get props => [rate, count];

  @override
  String toString() => '$rate ($count reviews)';
}
