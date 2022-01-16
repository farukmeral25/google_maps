import 'package:dartz/dartz.dart';
import 'package:google_maps_location/feature/_feature_exports.dart';
import 'package:google_maps_location/core/_core_exports.dart';

class FetchLocationDataUsecase implements Usecase<List<LocationData>, NoParams> {
  MapRepo mapRepo;
  FetchLocationDataUsecase({
    required this.mapRepo,
  });
  @override
  Future<Either<Failure, List<LocationData>>> call(NoParams params) async {
    return await mapRepo.fetchLocationData();
  }
}
