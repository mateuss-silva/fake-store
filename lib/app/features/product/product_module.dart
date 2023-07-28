import 'package:dio/dio.dart';
import 'package:fake_store/app/features/product/domain/usecases/add_to_favorites_usecase.dart';
import 'package:fake_store/app/features/product/domain/usecases/remove_from_favorites_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/favorite_local_datasource_impl.dart';
import 'data/datasources/product_datasource_impl.dart';
import 'data/repositories/favorite_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/usecases/filter_products_usecase.dart';
import 'domain/usecases/get_favorites_usecase.dart';
import 'domain/usecases/get_product_usecase.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'domain/usecases/is_favorites_usecase.dart';
import 'presentation/pages/error_page.dart';
import 'presentation/pages/favorites_page.dart';
import 'presentation/pages/product_details_page.dart';
import 'presentation/pages/products_page.dart';
import 'presentation/stores/favorites/favorites_store.dart';
import 'presentation/stores/product_details/product_details_store.dart';
import 'presentation/stores/products/products_store.dart';

class ProductModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ProductDataSourceImpl(i<Dio>())),
    Bind.factory((i) => FavoriteLocalDataSourceImpl(i<SharedPreferences>())),
    Bind.factory((i) => ProductRepositoryImpl(i<ProductDataSourceImpl>())),
    Bind.factory(
        (i) => FavoriteRepositoryImpl(i<FavoriteLocalDataSourceImpl>())),
    Bind.factory((i) => GetProductsUsecase(i<ProductRepositoryImpl>())),
    Bind.factory((i) => GetProductUsecase(i<ProductRepositoryImpl>())),
    Bind.factory((i) => FilterProductsUsecase()),
    Bind.factory((i) => GetFavoritesUsecase(i<FavoriteRepositoryImpl>())),
    Bind.factory((i) => IsFavoriteUsecase(i<FavoriteRepositoryImpl>())),
    Bind.factory((i) => AddToFavoritesUsecase(i<FavoriteRepositoryImpl>())),
    Bind.factory(
        (i) => RemoveFromFavoritesUsecase(i<FavoriteRepositoryImpl>())),
    Bind.singleton((i) =>
        ProductsStore(i<GetProductsUsecase>(), i<FilterProductsUsecase>())),
    Bind.lazySingleton((i) => FavoritesStore(
          i<GetFavoritesUsecase>(),
          i<IsFavoriteUsecase>(),
          i<AddToFavoritesUsecase>(),
          i<RemoveFromFavoritesUsecase>(),
        )),
    Bind.factory((i) => ProductDetailsStore(i<GetProductUsecase>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const ProductsPage()),
    ChildRoute('/details',
        child: (_, args) => ProductDetailsPage(product: args.data)),
    ChildRoute('/favorites', child: (_, __) => const FavoritesPage()),
    ChildRoute('/error', child: (_, __) => const ErrorPage()),
  ];
}
