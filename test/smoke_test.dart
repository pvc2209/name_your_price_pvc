import 'package:flutter_test/flutter_test.dart';

import 'package:name_your_price_pvc/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
