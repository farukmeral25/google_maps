// ignore_for_file: unused_local_variable

import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_location/feature/_feature_exports.dart';
import 'package:google_maps_location/core/_core_exports.dart';

class UserLocationProvider extends ChangeNotifier {
  late BuildContext mapContext;

  late GoogleMapController mapController;
  Set<Marker> mapMarkers = {};
  LatLng _southWest = const LatLng(85, 170), _northEast = const LatLng(-85, -170);
  double _west = double.maxFinite, _east = double.negativeInfinity;

  UserLocationProvider(this._fetchLocationDataUsecase);
  final FetchLocationDataUsecase _fetchLocationDataUsecase;
  List<LocationData> _listLocationData = [];

  late LocationData? selectedLocationData = LocationData();
  bool _infoCardVisibility = false;

  Future<void> fetchLocationData(BuildContext context) async {
    mapContext = context;
    final fetchLocationDataEither = await _fetchLocationDataUsecase(const NoParams());
    fetchLocationDataEither.fold(
      (failure) => Left(failure),
      (data) {
        _listLocationData = data;

        _setMarkers(_listLocationData);
      },
    );
  }

  Marker _createMarker(int index, LatLng markerLocation, Uint8List bmp) {
    return Marker(
      markerId: MarkerId(
        _listLocationData[index].containerId!.toString(),
      ),
      position: markerLocation,
      icon: BitmapDescriptor.fromBytes(bmp),
      infoWindow: InfoWindow(
        title: _listLocationData[index].address,
      ),
      onTap: () {
        selectedLocationData = _listLocationData[index];
        infoCardVisibility = true;
      },
      draggable: _listLocationData[index].draggable,
      onDragEnd: (dragStopLocation) {
        mapMarkers.removeWhere((element) => element.markerId.value == _listLocationData[index].containerId.toString());
        _listLocationData[index].lat = dragStopLocation.latitude;
        _listLocationData[index].lon = dragStopLocation.longitude;
        Marker newPositionMarker = _createMarker(index, dragStopLocation, bmp);
        mapMarkers.add(newPositionMarker);
      },
    );
  }

  List<Marker> _mapBitmapsToMarkers(List<Uint8List> bitmaps, List<LocationData> dataList) {
    List<Marker> markersList = [];
    bitmaps.asMap().forEach(
      (i, bmp) {
        final data = dataList[i];
        LatLng markerLocation = LatLng(data.lat!, data.lon!);
        _createCornerPoints(markerLocation);
        markersList.add(_createMarker(i, markerLocation, bmp));
      },
    );
    _setCenterTheMap();
    return markersList;
  }

  List<Widget> _createParkMarkers(List<LocationData> dataList) {
    notifyListeners();
    return dataList.map((item) => _getMarkerWidget(item)).toList();
  }

  void reLocate() {
    Marker deleteMarker =
        mapMarkers.firstWhere((element) => element.markerId.value == selectedLocationData?.containerId.toString());
    mapMarkers.remove(deleteMarker);
    mapMarkers.add(
      deleteMarker.copyWith(
        draggableParam: true,
      ),
    );
    notifyListeners();
  }

  void _setMarkers(List<LocationData> dataList) {
    MarkerGenerator(
      _createParkMarkers(dataList),
      (bitmaps) {
        List<Marker> markers = _mapBitmapsToMarkers(bitmaps, dataList);
        mapMarkers.addAll(markers);
        Future.delayed(
          const Duration(milliseconds: 250),
          () {
            notifyListeners();
          },
        );
      },
    ).generate(mapContext);
  }

  void _setCenterTheMap() {
    _northEast = LatLng(_northEast.latitude, _east);
    _southWest = LatLng(_southWest.latitude, _west);
    LatLngBounds bound = LatLngBounds(northeast: _northEast, southwest: _southWest);
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bound, 90);
    mapController.animateCamera(cameraUpdate).then((void v) {});
  }

  void _createCornerPoints(LatLng latLng) {
    //* Kuzey köşesi ayarlanır
    if (latLng.latitude >= _northEast.latitude) {
      _northEast = latLng;
    }
    //* Güney köşesi ayarlanır
    if (latLng.latitude <= _southWest.latitude) {
      _southWest = latLng;
    }
    if (_east <= latLng.longitude) {
      _east = latLng.longitude;
    }
    if (_west >= latLng.longitude) {
      _west = latLng.longitude;
    }
  }

  Widget _getMarkerWidget(LocationData data) {
    return CircleAvatar(
      backgroundColor: _colorFillRatio(data.solidityRatio!),
      radius: ScreenSize().getWidthPercent(.08),
      child: Icon(
        Icons.location_on_outlined,
        color: Colors.white,
        size: ScreenSize().getWidthPercent(.1),
      ),
    );
  }

  Color _colorFillRatio(double ratio) {
    if (ratio < 40) {
      return Colors.green;
    } else if (ratio < 75) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  bool get infoCardVisibility => _infoCardVisibility;
  set infoCardVisibility(bool value) {
    _infoCardVisibility = value;
    notifyListeners();
  }
}
