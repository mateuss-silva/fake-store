import 'package:dio/dio.dart';

import '../../../../core/common/constants.dart';
import '../../../../core/common/extensions/status_code_extension.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';
import 'product_datasource.dart';

class ProductDataSourceImpl implements ProductDataSource {
  final Dio client;

  ProductDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getAll() async {
    final response = await client.get('$baseUrl/products');

    if (response.statusCode.isSuccessCode) {
      return ProductModel.fromJsonList(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> get(int id) async {
    final response = await client.get('$baseUrl/products/$id');

    if (response.statusCode.isSuccessCode) {
      return ProductModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
