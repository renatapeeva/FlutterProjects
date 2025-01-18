import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/ExamProvider.dart';

class MapScreen extends StatefulWidget {
  final LatLng? destination;

  const MapScreen({super.key, this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    final events = context.read<ExamProvider>().events;
    setState(() {
      _markers = events.map((event) {
        return Marker(
          markerId: MarkerId(event.title),
          position: event.location,
          infoWindow: InfoWindow(
            title: event.title,
            snippet: event.dateTime.toString(),
          ),
        );
      }).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Locations')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.destination ?? const LatLng(0, 0),
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
      ),
    );
  }
}