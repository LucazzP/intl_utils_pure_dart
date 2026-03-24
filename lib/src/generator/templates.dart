import 'label.dart';

String generateL10nDartFileContent(
  String className,
  List<Label> labels,
  List<String> locales, [
  bool otaEnabled = false,
]) {
  return """
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:intl/intl.dart';${otaEnabled ? '\n${_generateLocalizelySdkImport()}' : ''}
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class $className {
  $className();

  static $className? _current;

  static $className get current {
    assert(_current != null, 'No instance of $className was loaded. Try to initialize the locale by calling $className.load before accessing $className.current.');
    return _current!;
  }

  static final List<String> supportedLocales =
      <String>[
${locales.map((locale) => _generateSupportedLocale(locale)).join("\n")}
      ].map(Intl.canonicalizedLocale).toList(growable: false);

  static Future<$className> load(String locale) {
    final localeName = Intl.canonicalizedLocale(locale);${otaEnabled ? '\n${_generateMetadataSetter()}' : ''}
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = $className();
      $className._current = instance;

      return instance;
    });
  }

  static bool isSupported(String locale) => supportedLocales.contains(Intl.canonicalizedLocale(locale));
${otaEnabled ? '\n${_generateMetadata(labels)}\n' : ''}
${labels.map((label) => label.generateDartGetter()).join("\n\n")}
}
""".trim();
}

String _generateSupportedLocale(String locale) => "    '$locale',";

String _generateLocalizelySdkImport() {
  return "import 'package:localizely_sdk/localizely_sdk.dart';";
}

String _generateMetadataSetter() {
  return [
    '    if (!Localizely.hasMetadata()) {',
    '      Localizely.setMetadata(_metadata);',
    '    }',
  ].join('\n');
}

String _generateMetadata(List<Label> labels) {
  return [
    '  static final Map<String, List<String>> _metadata = {',
    labels.map((label) => label.generateMetadata()).join(',\n'),
    '  };',
  ].join('\n');
}
