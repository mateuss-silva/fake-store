import 'package:fake_store/app/app_module.dart';
import 'package:fake_store/app/features/product/presentation/widgets/empty_list_widget.dart';
import 'package:fake_store/app/features/product/presentation/widgets/product_card_widget.dart';
import 'package:fake_store/app/features/product/presentation/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../stores/favorites/favorites_store.dart';
import '../stores/products/products_store.dart';
import '../widgets/search_bar_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final store = Modular.get<ProductsStore>();

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.getProducts();
    store.addListener(() {
      if (store.value is ProductsErrorState) {
        Modular.to.pushNamed('/error');
      }
    });
    registeFavoriteErrorListener();
  }

  void registeFavoriteErrorListener() async {
    await Modular.isModuleReady<AppModule>();
    final favoriteStore = Modular.get<FavoritesStore>();
    favoriteStore.addListener(() {
      var state = favoriteStore.value;
      if (state is FavoritesErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              Modular.to.pushNamed('/favorites');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SearchBarWidget(
                controller: _searchController,
                onChanged: store.searchProducts,
              )),
          ValueListenableBuilder(
              valueListenable: store,
              builder: (context, state, widget) {
                if (state is ProductsLoadingState) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 64.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is ProductsErrorState) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 64.0, horizontal: 14.0),
                      child: RetryWidget(
                        message: state.message,
                        onPressed: store.getProducts,
                      ),
                    ),
                  );
                }

                final products =
                    (state as ProductsLoadedState).filteredProducts;

                if (products.isEmpty) {
                  return const Expanded(
                    child: Center(child: EmptyListWidget()),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: ProductCardWidget(product: products[index]),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}
