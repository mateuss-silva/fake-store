import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../app_module.dart';
import '../../domain/entities/product.dart';
import '../stores/favorites/favorites_store.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final Product product;
  const FavoriteButtonWidget({super.key, required this.product});

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  void initState() {
    super.initState();
    _verifyIfIsFavorite();
  }

  @override
  void didUpdateWidget(covariant FavoriteButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _verifyIfIsFavorite();
  }

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: _isFavorite
          ? const Icon(Icons.favorite, color: Color(0xFFFF0000))
          : const Icon(Icons.favorite_border, color: Colors.grey),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      Modular.get<FavoritesStore>().addToFavorites(widget.product);
    } else {
      Modular.get<FavoritesStore>().removeFromFavorites(widget.product);
    }
  }

  Future<void> _verifyIfIsFavorite() async {
    await Modular.isModuleReady<AppModule>();
    var isFavorite =
        await Modular.get<FavoritesStore>().isFavorite(widget.product);
    setState(() {
      _isFavorite = isFavorite;
    });
  }
}
