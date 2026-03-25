import 'package:intl_utils/src/generator/label.dart';
import 'package:intl_utils/src/generator/templates.dart';
import 'package:intl_utils/src/intl_translation/generate_localized.dart';
import 'package:test/test.dart';

void main() {
  group('Pure Dart generator output', () {
    test('generates l10n content without Flutter APIs', () {
      final content = generateL10nDartFileContent('S', [
        Label('hello', 'Hello'),
      ], [
        'en',
        'en_GB',
      ]);

      expect(content, isNot(contains('package:flutter')));
      expect(content, isNot(contains('dart:ui')));
      expect(content, isNot(contains('BuildContext')));
      expect(content, isNot(contains('LocalizationsDelegate')));
      expect(content, isNot(contains('Locale.fromSubtags')));
      expect(content, contains('static final List<String> supportedLocales'));
      expect(content, contains("    'en',"));
      expect(content, contains("    'en_GB',"));
      expect(content, contains('.map(Intl.canonicalizedLocale).toList(growable: false);'));
      expect(content, contains('static Future<S> load(String locale)'));
      expect(content, contains('static bool isSupported(String locale)'));
    });

    test('generates messages_all content without Flutter imports', () {
      final generation =
          MessageGeneration()
            ..useDeferredLoading = false
            ..allLocales.addAll(['en', 'en_GB']);

      final content = generation.generateMainImportFile();

      expect(content, isNot(contains('package:flutter/foundation.dart')));
      expect(content, isNot(contains('SynchronousFuture')));
      expect(content, isNot(contains('dart:ui')));
      expect(content, contains("  'en': () => Future.value(null),"));
      expect(
        content,
        contains('Future<bool> initializeMessages(String localeName) async {'),
      );
      expect(
        content,
        contains('initializeInternalMessageLookup(() => CompositeMessageLookup());'),
      );
    });
  });
}
