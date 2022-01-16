import 'dart:convert';

import 'package:google_maps_location/feature/_feature_exports.dart';

class LocationListDataModel {
  final List<LocationDataModel> listLocationDataModel;

  LocationListDataModel(this.listLocationDataModel);

  Map<String, dynamic> toMap() {
    return {
      'listLocationDataModel': listLocationDataModel.map((x) => x.toMap()).toList(),
    };
  }

  factory LocationListDataModel.fromMap(Map<String, dynamic> map) {
    return LocationListDataModel(
      List<LocationDataModel>.from(map['listLocationDataModel']?.map((x) => LocationDataModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationListDataModel.fromJson(String source) => LocationListDataModel.fromMap(json.decode(source));
}
