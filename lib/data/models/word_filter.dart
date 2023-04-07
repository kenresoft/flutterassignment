class WordFilter {
  WordFilter({
    this.clean,
    this.language,
    this.profanities,
  });

  WordFilter.fromJson(dynamic json) {
    clean = json['clean'];
    language = json['language'];
    profanities = json['profanities'] != null ? json['profanities'].cast<String>() : [];
  }

  String? clean;
  String? language;
  List<String>? profanities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clean'] = clean;
    map['language'] = language;
    map['profanities'] = profanities;
    return map;
  }
}
