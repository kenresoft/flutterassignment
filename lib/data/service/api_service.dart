import 'dart:convert';
import 'dart:developer';

import 'package:flutterassignment/data/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../models/picture_filter.dart';
import '../models/word_filter.dart';

class ApiService {
  Future<WordFilter?> getWordFilter(
    String sentence, {
    String maskCharacter = 'x',
    String language = Constants.language,
  }) async {
    http.Response response = await http.post(
      Uri.parse(Constants.url(ApiVariant.word)),
      headers: Constants.header(ApiVariant.word),
      body: json.encode({
        "text": sentence,
        "maskCharacter": maskCharacter,
        "language": language,
      }),
    );

    if (response.statusCode != 200) {
      Exception('No Response');
      return WordFilter(clean: response.body.toString());
    }
    return WordFilter.fromJson(json.decode(response.body));
  }

  Future<PictureFilter> getImageFilter(String image) async {
    http.Response response = await http.post(
      Uri.parse(Constants.url(ApiVariant.image)),
      headers: Constants.header(ApiVariant.image),
      body: json.encode({
        "api_key": 'test_fake_image_rapid',
        "base64_image": image,
      }),
    );

    if (response.statusCode != 200) {
      log('No Response');
      PictureFilter(errorCode: 10000);
    }
    log(PictureFilter.fromJson(json.decode(response.body)).toString());
    return PictureFilter.fromJson(json.decode(response.body));
  }
}
