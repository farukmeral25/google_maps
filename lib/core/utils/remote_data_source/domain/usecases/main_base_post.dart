import 'package:dartz/dartz.dart';
import 'package:google_maps_location/core/_core_exports.dart';

class MainBasePost implements Usecase<String, PostRequestParams> {
  BaseRequestRepository repository;

  MainBasePost(this.repository);

  @override
  Future<Either<Failure, String>> call(params) async {
    return await repository.basePost(
      requestBody: params.requestBody,
      endPoint: params.endPoint,
    );
  }
}
