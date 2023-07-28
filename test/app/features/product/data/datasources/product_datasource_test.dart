import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fake_store/app/core/common/constants.dart';
import 'package:fake_store/app/core/error/exceptions.dart';
import 'package:fake_store/app/features/product/data/datasources/product_datasource_impl.dart';
import 'package:fake_store/app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_render.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late MockDioClient mockDioClient;
  late ProductDataSourceImpl productDataSource;

  setUp(() {
    mockDioClient = MockDioClient();
    productDataSource = ProductDataSourceImpl(mockDioClient);
  });

  final tProducts =
      ProductModel.fromJsonList(json.decode(fixture("products.json")));

  group('Product DataSource success', () {
    test('should perform a GET on a url with products being the endpoint',
        () async {
      // arrange
      when(() => mockDioClient.get(any())).thenAnswer(
        (_) async => Response(
          data: json.decode(fixture("products.json")),
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      // act
      await productDataSource.getAll();

      // assert
      verify(() => mockDioClient.get("$baseUrl/products"));
    });

    test('should perform a GET on a url with product by id being the endpoint',
        () async {
      // arrange
      when(() => mockDioClient.get(any())).thenAnswer(
        (_) async => Response(
          data: json.decode(fixture("product.json")),
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      // act
      await productDataSource.get(1);

      // assert
      verify(() => mockDioClient.get("$baseUrl/products/1"));
    });

    test('should return a List of ProductModel when the response code is 200',
        () async {
      // arrange
      when(() => mockDioClient.get(any())).thenAnswer(
        (_) async => Response(
          data: json.decode(fixture("products.json")),
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      // act
      final result = await productDataSource.getAll();

      // assert
      expect(result, tProducts);
    });
  });

  group('Product DataSource failure', () {
    test(
        'should throw a ServerException when the response of get products code is 404 or other',
        () async {
      // arrange
      when(() => mockDioClient.get(any())).thenAnswer(
        (_) async => Response(
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
      );

      // act
      final call = productDataSource.getAll;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });

    test(
        'should throw a ServerException when the response of get product by id code is 404 or other',
        () async {
      // arrange
      when(() => mockDioClient.get(any())).thenAnswer(
        (_) async => Response(
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
      );

      // act
      final call = productDataSource.get;

      // assert
      expect(() => call(1), throwsA(isA<ServerException>()));
    });
  });
}
