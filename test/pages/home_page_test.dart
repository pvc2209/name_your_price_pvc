import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:name_your_price_pvc/pages/home_page.dart';

void main() {
  group("Home page test", () {
    Finder checkBtn() => find.text("Check");
    Finder nextBtn() => find.text("Next");
    Finder priceInput() => find.byKey(const Key("priceInput"));

    testWidgets("Click Next to iterate over the product list",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(find.text(products[0].name), findsOneWidget);

      for (int i = 1; i < products.length; ++i) {
        await tester.tap(checkBtn());
        await tester.pump();

        await tester.tap(nextBtn());
        await tester.pump();
        expect(find.text(products[i].name), findsOneWidget);
      }

      await tester.tap(checkBtn());
      await tester.pump();
      await tester.tap(nextBtn());
      await tester.pump();
      expect(find.text(products[products.length - 1].name), findsOneWidget);
    });

    testWidgets("Show result & show next product", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key("result")), findsNothing);

      await tester.enterText(priceInput(), products[0].price.toString());
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key("result")), findsOneWidget);
      expect(find.text("pass"), findsOneWidget);

      await tester.tap(nextBtn());
      await tester.pump();

      expect(nextBtn(), findsNothing);
      await tester.enterText(priceInput(), "4000001");
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key("result")), findsOneWidget);
      expect(find.text("fail"), findsOneWidget);

      await tester.enterText(priceInput(), "4000000");
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text("pass"), findsOneWidget);
    });
  });
}
