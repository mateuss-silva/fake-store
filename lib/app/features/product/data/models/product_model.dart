import '../../../../core/common/types.dart';
import '../../domain/entities/product.dart';
import '../value_objects/money.dart';
import '../value_objects/rating.dart';

final class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  ProductModel.fromEntity(Product product)
      : this(
          id: product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          category: product.category,
          image: product.image,
          rating: product.rating,
        );

  factory ProductModel.fromJson(Json json) => ProductModel(
        id: json['id'].toInt(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        category: json['category'].toString(),
        image: json['image'].toString(),
        price: Money(double.parse(json['price'].toString())),
        rating: Rating.fromJson(json['rating']),
      );

  Json toJson() => {
        'id': id,
        'title': title,
        'price': price.price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating.toJson(),
      };

  static List<ProductModel> fromJsonList(List jsonList) =>
      jsonList.map((json) => ProductModel.fromJson(json)).toList();
}
