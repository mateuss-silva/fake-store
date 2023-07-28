import 'package:fake_store/app/features/product/presentation/widgets/favorite_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/product.dart';
import '../stores/product_details/product_details_store.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final store = Modular.get<ProductDetailsStore>();

  @override
  void initState() {
    super.initState();
    store.init(widget.product);
    _registerLoadingListenerHandler();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store.getProduct(widget.product.id);
    });
    _registerErrorListenerHandle();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  late Product product = widget.product;

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Color(0xFF37474F),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(),
        actions: [
          FavoriteButtonWidget(product: product),
        ],
      ),
      body: ValueListenableBuilder<ProductDetailsState>(
          valueListenable: store,
          builder: (context, state, widget) {
            if (state is ProductDetailsLoadedState) product = state.product;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Hero(
                  tag: product.id,
                  child: Image.network(
                    product.image,
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  product.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 4.0, bottom: 4),
                      child: Icon(Icons.star_rate, color: Colors.amberAccent),
                    ),
                    Text(
                      product.rating.toString(),
                      maxLines: 2,
                      style: const TextStyle(
                        color: Color(0xA537474F),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      product.price.usd,
                      style: const TextStyle(
                        color: Color(0xFF5EC401),
                        fontSize: 29,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.sort, color: Color(0XFF37474F)),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        product.category,
                        style: const TextStyle(
                          color: Color(0xFF3E3E3E),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.60,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.menu, color: Color(0XFF37474F)),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        product.description,
                        style: const TextStyle(
                          color: Color(0xFF3E3E3E),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.60,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  _registerErrorListenerHandle() {
    store.addListener(() {
      var state = store.value;
      if (state is ProductDetailsErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: const Color(0xFFFF0000),
          ),
        );
      }
    });
  }

  void _registerLoadingListenerHandler() {
    store.addListener(() {
      if (store.value is ProductDetailsLoadingState) {
        _showLoading();
      } else {
        Modular.to.pop();
      }
    });
  }

  void _showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Align(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
