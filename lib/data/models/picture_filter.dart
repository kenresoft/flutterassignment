import 'predictions.dart';

class PictureFilter {
  PictureFilter({
    this.errorCode,
    this.message,
    this.predictions,
  });

  PictureFilter.fromJson(dynamic json) {
    errorCode = json['error_code'];
    message = json['message'] ?? 'No message returned!';
    predictions = json['predictions'] != null ? Predictions.fromJson(json['predictions']) : null;
  }

  int? errorCode;
  String? message;
  Predictions? predictions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error_code'] = errorCode;
    message != null ? map['message'] = message : 'No message!';
    if (predictions != null) {
      map['predictions'] = predictions?.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'PictureFilter(errorCode: $errorCode, message: $message, predictions: $predictions)';
  }
}
