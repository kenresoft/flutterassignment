class Predictions {
  Predictions({
    this.appearanceClothingSwimwearBikini,
    this.appearanceClothingUnderwearLingerie,
    this.artificialimages,
    this.compositionOneFemale,
    this.unsafe,
  });

  Predictions.fromJson(dynamic json) {
    appearanceClothingSwimwearBikini = json['appearance_clothing_swimwear_bikini'];
    appearanceClothingUnderwearLingerie = json['appearance_clothing_underwear_lingerie'];
    artificialimages = json['artificial-images'];
    compositionOneFemale = json['composition_one_female'];
    unsafe = json['unsafe'];
  }

  double? appearanceClothingSwimwearBikini;
  double? appearanceClothingUnderwearLingerie;
  double? artificialimages;
  double? compositionOneFemale;
  int? unsafe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appearance_clothing_swimwear_bikini'] = appearanceClothingSwimwearBikini;
    map['appearance_clothing_underwear_lingerie'] = appearanceClothingUnderwearLingerie;
    map['artificial-images'] = artificialimages;
    map['composition_one_female'] = compositionOneFemale;
    map['unsafe'] = unsafe;
    return map;
  }

  @override
  String toString() {
    return '''Predictions(unsafe: $unsafe,
        appearanceClothingSwimwearBikini: $appearanceClothingSwimwearBikini,
        appearanceClothingUnderwearLingerie: $appearanceClothingUnderwearLingerie,
        compositionOneFemale: $compositionOneFemale,
        artificialimages: $artificialimages)''';
  }
}
