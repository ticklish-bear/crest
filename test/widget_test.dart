import 'package:flutter_test/flutter_test.dart';
import 'package:crest/main.dart';

void main() {
  testWidgets('App launches', (WidgetTester tester) async {
    await tester.pumpWidget(const CrestApp());
    expect(find.text('Crest'), findsOneWidget);
  });
}
