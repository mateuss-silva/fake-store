import '../../../../core/entities/entity.dart';
import '../../data/value_objects/money.dart';
import '../../data/value_objects/rating.dart';

base class Product extends Entity {
  final String title;
  final String description;
  final String category;
  final Money price;
  final String image;
  final Rating rating;

  const Product({
    required super.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.image,
    required this.rating,
  });

  static List<Product> filterByQuery(String query, List<Product> products) {
    return products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  List<Object> get props => [id, title, description, price, image];
}
