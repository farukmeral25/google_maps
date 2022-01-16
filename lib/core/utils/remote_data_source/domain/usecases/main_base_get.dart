import 'package:dartz/dartz.dart';
import 'package:google_maps_location/core/_core_exports.dart';

class MainBaseGet implements Usecase<String, GetRequestParams> {
  BaseRequestRepository repository;

  MainBaseGet(this.repository);

  @override
  Future<Either<Failure, String>> call(params) async {
    return await repository.baseGet(
      endPoint: params.endPoint,
    );
  }
}
