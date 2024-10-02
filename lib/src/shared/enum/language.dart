import '../../gen/assets.gen.dart';

enum Language {
  english(
    languageName: 'English',
    languageCode: 'en',
  ),
  french(
    languageName: 'French',
    languageCode: 'fr',
  ),
  german(
    languageName: 'German',
    languageCode: 'de',
  ),
  hindi(
    languageName: 'Hindi',
    languageCode: 'hi',
  ),
  indonesia(
    languageName: 'Indonesia',
    languageCode: 'in',
  ),
  afrikaans(
    languageName: 'Afrikaans',
    languageCode: 'af',
  ),
  bangladesh(
    languageName: 'Bangladesh',
    languageCode: 'bn',
  ),
  turkish(
    languageName: 'Turkish',
    languageCode: 'tr',
  ),
  ;

  const Language({
    required this.languageCode,
    required this.languageName,
  });

  final String languageCode;
  final String languageName;

  @override
  String toString() => languageName;
}

extension LanguageExtension on Language {
  String get flagPath {
    switch (this) {
      case Language.english:
        return Assets.images.languages.en.path;
      case Language.french:
        return Assets.images.languages.fr.path;
      case Language.german:
        return Assets.images.languages.ge.path;
      case Language.hindi:
        return Assets.images.languages.hi.path;
      case Language.indonesia:
        return Assets.images.languages.indonesia.path;
      case Language.afrikaans:
        return Assets.images.languages.afrikaans.path;
      case Language.bangladesh:
        return Assets.images.languages.bangladesh.path;
      case Language.turkish:
        return Assets.images.languages.turkish.path;
    }
  }
}
