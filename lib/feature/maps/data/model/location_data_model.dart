import 'dart:convert';

import 'package:google_maps_location/feature/_feature_exports.dart';

class LocationDataModel extends LocationData {
  LocationDataModel({
    int? containerId,
    double? lat,
    double? lon,
    DateTime? dateTime,
    double? solidityRatio,
    String? address,
  }) : super(
          containerId: containerId,
          lat: lat,
          lon: lon,
          dateTime: dateTime,
          solidityRatio: solidityRatio,
          address: address,
        );

  Map<String, dynamic> toMap() {
    return {
      'containerId': containerId,
      'lat': lat,
      'lon': lon,
      'dateTime': dateTime,
      'solidityRatio': solidityRatio,
      'address': address,
    };
  }

  factory LocationDataModel.fromMap(Map<String, dynamic> map) {
    return LocationDataModel(
      containerId: map['containerId']?.toInt() ?? 0,
      lat: map['lat']?.toDouble() ?? 0.0,
      lon: map['lon']?.toDouble() ?? 0.0,
      dateTime: DateTime.parse(map['dateTime']),
      solidityRatio: map['solidityRatio']?.toDouble() ?? 0.0,
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationDataModel.fromJson(String source) => LocationDataModel.fromMap(json.decode(source));
}
