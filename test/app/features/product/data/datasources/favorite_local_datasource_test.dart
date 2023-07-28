import 'dart:convert';

import 'package:fake_store/app/features/product/data/datasources/favorite_local_datasource_impl.dart';
import 'package:fake_store/app/features/product/data/models/product_model.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_render.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late FavoriteLocalDataSourceImpl favoriteDatasource;

  final favoritesListOfMap = json.decode(fixture("products.json")) as List;
  final favorites = favoritesListOfMap
      .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
      .toList();

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'favorites': favoritesListOfMap.map((e) => e['id'].toString()).toList(),
      '1': json.encode(favoritesListOfMap[0]),
      '2': json.encode(favoritesListOfMap[1]),
      '3': json.encode(favoritesListOfMap[2]),
      '4': json.encode(favoritesListOfMap[3]),
      '5': json.encode(favoritesListOfMap[4]),
      '6': json.encode(favoritesListOfMap[5]),
      '7': json.encode(favoritesListOfMap[6]),
      '8': json.encode(favoritesListOfMap[7]),
      '9': json.encode(favoritesListOfMap[8]),
      '10': json.encode(favoritesListOfMap[9]),
    });
    sharedPreferences = await SharedPreferences.getInstance();
    favoriteDatasource = FavoriteLocalDataSourceImpl(sharedPreferences);
  });

  group('Favorite datasource', () {
    test('should return a list of favorites', () async {
      // arrange

      // act
      final result = await favoriteDatasource.getAll();
      // assert
      expect(result, equals(favorites));
    });

    // is favorite
    test('should return true if product is favorite', () async {
      // arrange
      final product = favorites[0];
      // act
      final result = await favoriteDatasource.isFavorite(product);
      // assert
      expect(result, equals(true));
    });

    test('should add product to favorites', () async {
      // arrange
      const product = ProductModel(
        id: 11,
        title: 'title',
        description: 'description',
        price: Money(10),
        category: 'category',
        image: 'image',
        rating: Rating(count: 1, rate: 1.0),
      );
      // act
      await favoriteDatasource.add(product);
      var result = await favoriteDatasource.isFavorite(product);
      // assert
      expect(result, true);
    });

    test('should remove product from favorites', () async {
      // arrange
      final product = favorites[0];
      // act
      await favoriteDatasource.remove(product);
      final result = await favoriteDatasource.isFavorite(product);
      // assert
      expect(result, false);
    });
  });
}
