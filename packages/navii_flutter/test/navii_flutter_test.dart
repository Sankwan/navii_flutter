import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navii_flutter/navii_flutter.dart';

void main() {
  group('Navii widget', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Navii(seed: 'test-user'),
        ),
      );
      expect(find.byType(Navii), findsOneWidget);
    });

    testWidgets('default size is 48', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Navii(seed: 'alice'),
        ),
      );
      final widget = tester.widget<Navii>(find.byType(Navii));
      expect(widget.size, equals(48.0));
    });

    testWidgets('respects custom size', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Navii(seed: 'alice', size: 96),
        ),
      );
      final widget = tester.widget<Navii>(find.byType(Navii));
      expect(widget.size, equals(96.0));
    });

    testWidgets('same seed renders consistently', (tester) async {
      const seed = 'stable-seed';

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Navii(seed: seed),
        ),
      );
      expect(find.byType(Navii), findsOneWidget);

      // Rebuild with same seed — widget should not throw
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Navii(seed: seed),
        ),
      );
      expect(find.byType(Navii), findsOneWidget);
    });

    testWidgets('renders multiple avatars in a list', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 400,
            height: 600,
            child: ListView(
              children: List.generate(
                20,
                (i) => Navii(seed: 'user-$i', size: 48),
              ),
            ),
          ),
        ),
      );
      expect(find.byType(Navii), findsWidgets);
    });

    testWidgets('empty string seed does not throw', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Navii(seed: ''),
        ),
      );
      expect(find.byType(Navii), findsOneWidget);
    });
  });
}
