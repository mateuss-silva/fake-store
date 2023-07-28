import 'package:fake_store/app/features/product/presentation/widgets/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('retry widget test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: RetryWidget(message: "message", onPressed: () {})),
    );

    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text("message"), findsOneWidget);
    expect(find.text("Retry"), findsOneWidget);
  });
}
