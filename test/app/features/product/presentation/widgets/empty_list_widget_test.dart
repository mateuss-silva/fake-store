import 'package:fake_store/app/features/product/presentation/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('empty list widget test', (tester) async {

    await tester.pumpWidget(const MaterialApp(home: EmptyListWidget()));

    final Finder imageFinder = find.byType(Image);
    final Finder textFinder = find.byType(Text);

    expect(imageFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });
}
