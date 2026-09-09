// Basic smoke test for the pronostics app: root tabs + main menu screen.

import 'package:flutter_test/flutter_test.dart';

import 'package:noxe/main.dart';

void main() {
  testWidgets('Root tabs are present and GRATUIT opens a match list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NoxeApp());

    expect(find.text('GRATUIT'), findsOneWidget);
    expect(find.text('CODE PROMO'), findsOneWidget);
    expect(find.text('VIP'), findsOneWidget);

    expect(find.text('PRONOS RECOMMANDÉS'), findsOneWidget);

    await tester.tap(find.text('PRONOS RECOMMANDÉS'));
    await tester.pumpAndSettle();

    expect(find.text('RÉCENT'), findsOneWidget);
    expect(find.text('HISTORIQUE'), findsOneWidget);
  });
}
