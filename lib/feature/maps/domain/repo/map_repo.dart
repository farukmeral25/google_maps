import 'package:dartz/dartz.dart';
import 'package:google_maps_location/feature/_feature_exports.dart';
import 'package:google_maps_location/core/_core_exports.dart';

abstract class MapRepo {
  Future<Either<Failure, List<LocationData>>> fetchLocationData();
}
