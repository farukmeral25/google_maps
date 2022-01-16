import 'package:dartz/dartz.dart';
import 'package:google_maps_location/feature/_feature_exports.dart';
import 'package:google_maps_location/core/_core_exports.dart';

class MapRepoImpl implements MapRepo {
  final MainBaseGet _mainBaseGet;

  MapRepoImpl(this._mainBaseGet);
  @override
  Future<Either<Failure, List<LocationData>>> fetchLocationData() async {
    try {
      final fetchLocationDataEither = await _mainBaseGet(GetRequestParams(endPoint: MainEndpoints.FETCH_LOCATION));

      return fetchLocationDataEither.fold(
        (failure) => Left(failure),
        (jsonData) {
          List<LocationDataModel> listLocationDataModel =
              LocationListDataModel.fromJson(jsonData).listLocationDataModel;
          return Right(listLocationDataModel);
        },
      );
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
