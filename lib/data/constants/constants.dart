import 'package:private_keys/private_keys.dart' as key;

class Constants {
  Constants._();

  static const String appName = 'Flutter Assignment';
  static const String root = '/';
  static const String home = '/home';
  static const String error = '/error';

  static const String _contentType = 'application/json';
  static const String _apiKey = key.Constants.rapidApiKey;

  static const String language = 'en';
  static const String _apiHostWord = 'profanity-cleaner-bad-word-filter.p.rapidapi.com';
  static const String _apiHostImage = 'generativeai-image-detection.p.rapidapi.com';
  static const String _urlWord = "https://profanity-cleaner-bad-word-filter.p.rapidapi.com/profanity";
  static const String _urlImage = "https://generativeai-image-detection.p.rapidapi.com/api-v1.0/SafeUnsafeImageWithTags";

  static Map<String, String> header(ApiVariant variant) =>
      {
        "content-type": _contentType,
        "X-RapidAPI-Key": _apiKey,
        "X-RapidAPI-Host": variant == ApiVariant.word ? _apiHostWord : _apiHostImage,
      };

  static String url(ApiVariant variant) => variant == ApiVariant.word ? _urlWord : _urlImage;

  static String get apiKey => _apiKey;
}

enum ApiVariant {
  word,
  image,
}
