class LocationData {
  int? containerId;
  double? lat;
  double? lon;
  DateTime? dateTime;
  double? solidityRatio;
  String? address;
  bool draggable;
  LocationData({
    this.containerId,
    this.lat,
    this.lon,
    this.dateTime,
    this.solidityRatio,
    this.address,
    this.draggable = false,
  });
}
