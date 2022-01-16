import 'package:google_maps_location/core/_core_exports.dart';

class PostRequestParams {
  final Map<String, dynamic> requestBody;
  final MainEndpoints endPoint;

  PostRequestParams({
    required this.requestBody,
    required this.endPoint,
  });
}
