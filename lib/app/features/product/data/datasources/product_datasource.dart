import '../models/product_model.dart';

abstract interface class ProductDataSource {
  Future<List<ProductModel>> getAll();

  Future<ProductModel> get(int id);
}
