import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import 'favorite_local_datasource.dart';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final SharedPreferences _sharedPreferences;
  static const key = 'favorites';

  FavoriteLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<ProductModel>> getAll() async {
    return _favoritesIds()
        .map((id) => ProductModel.fromJson(
            json.decode(_sharedPreferences.getString(id)!)))
        .toList();
  }

  @override
  Future<void> add(ProductModel product) async {
    if (!_exists(product)) {
      await _saveFavorite(product);
      await _updateFavoritesList(_addToFavorites(product));
    }
  }

  @override
  Future<bool> isFavorite(ProductModel product) async {
    return _exists(product);
  }

  @override
  Future<void> remove(ProductModel product) async {
    if (_exists(product)) {
      await _sharedPreferences.remove(product.id.toString());

      await _updateFavoritesList(_removeFromFavorites(product));
    }
  }

  List<String> _favoritesIds() {
    return _sharedPreferences.getStringList(key) ?? [];
  }

  bool _exists(ProductModel product) {
    return _favoritesIds().contains(product.id.toString());
  }

  List<String> _removeFromFavorites(ProductModel product) {
    return _favoritesIds()..remove(product.id.toString());
  }

  List<String> _addToFavorites(ProductModel product) {
    return _favoritesIds()..add(product.id.toString());
  }

  Future<void> _updateFavoritesList(List<String> products) async {
    await _sharedPreferences.setStringList(key, products);
  }

  Future<void> _saveFavorite(ProductModel product) async {
    await _sharedPreferences.setString(
        product.id.toString(), json.encode(product.toJson()));
  }
}
