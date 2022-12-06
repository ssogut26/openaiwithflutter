// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chatai/services/network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'OpenAiService create text',
    () async {
      final get = OpenAiService().movieToEmoji('Hello');
      expect(get, isNotNull);
    },
  );
  test(
    'OpenAiService create image',
    () async {
      final get = OpenAiService().createImage('I am stupid corner f1');
      expect(get, isNotNull);
    },
  );
}
