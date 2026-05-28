import 'package:flutter_test/flutter_test.dart';
import 'package:navii_example/main.dart';

void main() {
  testWidgets('Showcase app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NaviiShowcaseApp());
    await tester.pump();
    expect(find.byType(NaviiShowcaseApp), findsOneWidget);
  });
}
