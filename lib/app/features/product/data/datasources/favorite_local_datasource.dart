import '../models/product_model.dart';

abstract interface class FavoriteLocalDataSource {
  Future<List<ProductModel>> getAll();

  Future<void> add(ProductModel product);

  Future<void> remove(ProductModel product);

  Future<bool> isFavorite(ProductModel product);
}
