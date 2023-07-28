import 'package:fake_store/app/app_module.dart';
import 'package:fake_store/app/features/product/data/value_objects/money.dart';
import 'package:fake_store/app/features/product/data/value_objects/rating.dart';
import 'package:fake_store/app/features/product/domain/entities/product.dart';
import 'package:fake_store/app/features/product/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  setUp(() {
    initModule(AppModule());
  });

  const product = Product(
    id: 1,
    title: 'Product 1',
    price: Money(1),
    description: 'Description 1',
    category: 'Category 1',
    image: 'https://placehold.co/600x400',
    rating: Rating(rate: 1, count: 1),
  );

  testWidgets('ProductCardWidget displays the product information',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: ProductCardWidget(product: product))));

    final titleFinder = find.text(product.title);
    expect(titleFinder, findsOneWidget);

    final priceFinder = find.text(product.price.usd);
    expect(priceFinder, findsOneWidget);

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });
}
