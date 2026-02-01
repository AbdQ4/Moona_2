import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final MapController mapController = MapController();
  LatLng? selectedLocation;
  String address = "Move map to select location";

  /// 📍 Get current location
  Future<LatLng> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition();
    return LatLng(pos.latitude, pos.longitude);
  }

  /// 🔍 Search place
  Future<void> searchLocation(String query) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=json",
    );

    final res = await http.get(url);
    final data = jsonDecode(res.body);

    if (data.isNotEmpty) {
      final lat = double.parse(data[0]['lat']);
      final lon = double.parse(data[0]['lon']);
      mapController.move(LatLng(lat, lon), 16);
    }
  }

  /// 🔗 Paste link
  void handleLocationLink(String link) {
    final uri = Uri.tryParse(link);
    if (uri == null) return;

    if (uri.queryParameters.containsKey('q')) {
      final coords = uri.queryParameters['q']!.split(',');
      final lat = double.parse(coords[0]);
      final lng = double.parse(coords[1]);
      mapController.move(LatLng(lat, lng), 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location"), centerTitle: true),
      body: FutureBuilder<LatLng>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          selectedLocation ??= snapshot.data;

          return Column(
            children: [
              /// 🔍 Search
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search place",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: searchLocation,
                ),
              ),

              /// 🔗 Link
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Paste location link",
                    prefixIcon: Icon(Icons.link),
                  ),
                  onSubmitted: handleLocationLink,
                ),
              ),

              /// 🗺️ Map
              Expanded(
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: snapshot.data!,
                        initialZoom: 15,
                        onPositionChanged: (pos, _) {
                          selectedLocation = pos.center;
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: 'com.moona.app',
                        ),
                      ],
                    ),

                    /// 📍 Pin
                    const Center(
                      child: Icon(
                        Icons.location_pin,
                        size: 48,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              /// ✅ Confirm
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: selectedLocation == null
                      ? null
                      : () {
                          Navigator.pop(context, {
                            "lat": selectedLocation!.latitude,
                            "lng": selectedLocation!.longitude,
                            "address":
                                "${selectedLocation!.latitude}, ${selectedLocation!.longitude}",
                          });
                        },
                  child: const Text(
                    "Confirm Location",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
