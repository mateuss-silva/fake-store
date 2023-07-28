import 'package:fake_store/app/features/product/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController controller;

  setUp(() {
    controller = TextEditingController();
  });

  testWidgets('SearchBarWidget displays the search bar',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SearchBarWidget(
                controller: controller, onChanged: (search) {}))));

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    final iconButtonFinder = find.byType(Icon);
    expect(iconButtonFinder, findsOneWidget);
  });

  testWidgets('SearchBarWidget calls the onQueryChanged callback',
      (WidgetTester tester) async {
    String? query;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: SearchBarWidget(
        controller: controller,
        onChanged: (value) => query = value,
      ),
    )));

    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'test');

    expect(query, equals('test'));
  });
}
