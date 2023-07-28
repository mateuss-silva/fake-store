import 'package:fake_store/app/features/product/presentation/widgets/favorite_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/product.dart';

class ProductCardWidget extends StatefulWidget {
  final Product product;
  final bool readOnly;
  const ProductCardWidget({
    super.key,
    required this.product,
    this.readOnly = false,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.readOnly ? null : _navigateToDetails,
      child: SizedBox(
        height: 164,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Hero(
                  tag: widget.product.id,
                  child: Image.network(widget.product.image,
                      fit: BoxFit.fitHeight, height: 126, width: 126,
                      errorBuilder: (context, exception, stackTrace) {
                    return const Center(child: Icon(Icons.image_not_supported));
                  }),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF37474F),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0, bottom: 4),
                            child: Icon(Icons.star_rate,
                                color: Colors.amberAccent),
                          ),
                          Text(
                            widget.product.rating.toString(),
                            maxLines: 2,
                            style: const TextStyle(
                              color: Color(0xA537474F),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: !widget.readOnly,
                            child: FavoriteButtonWidget(
                              product: widget.product,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.product.price.usd,
                        style: const TextStyle(
                          color: Color(0xFFF37A20),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _navigateToDetails() async {
    await Modular.to.pushNamed('/details', arguments: widget.product);
    _forceChildToRebuildAndUpdateFavoriteValue();
  }

  _forceChildToRebuildAndUpdateFavoriteValue() {
    setState(() {});
  }
}
