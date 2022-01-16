import 'package:google_maps_location/core/_core_exports.dart';

class NullPointerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ListEmptyFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}
