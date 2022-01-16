import 'package:dartz/dartz.dart';
import 'package:google_maps_location/core/_core_exports.dart';

abstract class BaseRequestRepository {
  Future<Either<Failure, String>> basePost({
    required Map<String, dynamic> requestBody,
    required MainEndpoints endPoint,
  });

  Future<Either<Failure, String>> baseGet({
    required MainEndpoints endPoint,
  });
}
