import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExamEvent {
  final String title;
  final DateTime dateTime;
  final LatLng location;
  final String locationName;

  ExamEvent({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.locationName,
  });
}
