import 'package:fake_store/app/app_module.dart';
import 'package:fake_store/app/features/product/presentation/stores/favorites/favorites_store.dart';
import 'package:fake_store/app/features/product/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/retry_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesStore store;

  awaitInstanceSetAndGetData() async {
    await Modular.isModuleReady<AppModule>();
    store = Modular.get<FavoritesStore>();
    store.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Color(0xFF37474F),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(),
      ),
      body: FutureBuilder(
          future: awaitInstanceSetAndGetData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ValueListenableBuilder<FavoritesState>(
                valueListenable: store,
                builder: (context, state, widget) {
                  if (state is FavoritesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FavoritesErrorState) {
                    return Center(
                      child: RetryWidget(
                        message: state.message,
                        onPressed: store.getFavorites,
                      ),
                    );
                  }

                  final products = (state as FavoritesLoadedState).products;

                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCardWidget(
                        product: product,
                        readOnly: true,
                      );
                    },
                  );
                });
          }),
    );
  }
}
