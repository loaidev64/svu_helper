import 'package:flutter_test/flutter_test.dart';

import 'package:svu_helper/main.dart';

void main() {
  testWidgets('App renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SvuHelperApp());

    expect(find.text('SVU Helper'), findsOneWidget);
    expect(find.text('منصة تعليمية مساعدة'), findsOneWidget);
  });
}
