import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class Locationcontroller extends ChangeNotifier {
  /// ================================
  /// GET CURRENT LOCATION
  /// ================================
  Future<void> getUserLocation({
    required BuildContext context,
    required MapController mapController,
    required void Function(LatLng) onLocationDetected,
  }) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnack(context, "Location services are disabled ❌");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack(context, "Location permission denied ❌");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnack(context, "Permission permanently denied ❌");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final point = LatLng(position.latitude, position.longitude);

      onLocationDetected(point); // 🔥 update parent immediately

      mapController.move(point, 16);

      _showSnack(context, "Current location loaded ✅");
    } catch (_) {
      _showSnack(context, "Failed to get location ❌");
    }
  }

  /// ================================
  /// SHARE LOCATION
  /// ================================
  Future<void> shareLocation({
    required BuildContext context,
    required double? lat,
    required double? lng,
  }) async {
    if (lat == null || lng == null) {
      _showSnack(context, "Please select a location first");
      return;
    }

    final url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      _showSnack(context, "Opening in Maps ✅");
    } else {
      _showSnack(context, "Could not open maps ❌");
    }
  }

  /// ================================
  /// LOCATION PICKER WIDGET
  /// ================================
  Widget locationPicker({
    required BuildContext context,
    required MapController mapController,
    required double? selectedLat,
    required double? selectedLng,
    required double currentZoom,
    required ThemeController themeController,
    required void Function(void Function()) setModalState,
    required void Function(LatLng) onLocationSelected,
  }) {
    return Center(
      child: Container(
        width: 360.w,
        height: 450.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: themeController.isLight
                ? ColorsManager.grey.withAlpha(125)
                : ColorsManager.green.withAlpha(125),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: selectedLat != null
                      ? LatLng(selectedLat, selectedLng!)
                      : const LatLng(25.2048, 55.2708),
                  initialZoom: currentZoom,
                  onTap: (tapPosition, point) {
                    setModalState(() {
                      onLocationSelected(point);
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.moona.app',
                  ),
                  if (selectedLat != null && selectedLng != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(selectedLat, selectedLng),
                          width: 40.w,
                          height: 40.h,
                          child: Icon(
                            Icons.location_pin,
                            size: 40.sp,
                            color: ColorsManager.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),

              /// 📍 Current Location Button
              Positioned(
                right: 10.w,
                bottom: 140.h,
                child: FloatingActionButton(
                  heroTag: "loc",
                  mini: true,
                  backgroundColor: ColorsManager.green,
                  onPressed: () => getUserLocation(
                    context: context,
                    mapController: mapController,
                    onLocationDetected: (point) {
                      setModalState(() {
                        onLocationSelected(point);
                      });
                    },
                  ),
                  child: Icon(Icons.my_location, color: ColorsManager.white),
                ),
              ),

              /// ZoomIn Button
              Positioned(
                right: 10.w,
                bottom: 80.h,
                child: FloatingActionButton(
                  heroTag: "zoomIn",
                  mini: true,
                  backgroundColor: ColorsManager.green,
                  onPressed: () {
                    currentZoom++;
                    mapController.move(
                      mapController.camera.center,
                      currentZoom,
                    );
                  },
                  child: Icon(Icons.add, color: ColorsManager.white),
                ),
              ),

              /// ZoomOut Button
              Positioned(
                right: 10.w,
                bottom: 20.h,
                child: FloatingActionButton(
                  heroTag: "zoomOut",
                  mini: true,
                  backgroundColor: ColorsManager.green,
                  onPressed: () {
                    currentZoom--;
                    mapController.move(
                      mapController.camera.center,
                      currentZoom,
                    );
                  },
                  child: Icon(Icons.remove, color: ColorsManager.white),
                ),
              ),

              /// Share Location Button
              Positioned(
                left: 10.w,
                bottom: 20.h,
                child: FloatingActionButton(
                  heroTag: "share",
                  mini: true,
                  backgroundColor: ColorsManager.green,
                  onPressed: () => shareLocation(
                    context: context,
                    lat: selectedLat,
                    lng: selectedLng,
                  ),
                  child: Icon(Icons.share, color: ColorsManager.white),
                ),
              ),

              /// DONE BUTTON
              Positioned(
                right: 10.w,
                top: 10.w,
                child: FloatingActionButton(
                  heroTag: "done",
                  backgroundColor: ColorsManager.green,
                  onPressed: () {
                    if (selectedLat != null && selectedLng != null) {
                      Navigator.pop(context, LatLng(selectedLat, selectedLng));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Done",
                    style: GoogleFonts.inter(color: ColorsManager.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================================
  /// VIEW ONLY MAP
  /// ================================
  Widget viewLocation({required double lat, required double lng}) {
    return Container(
      height: 200.h,
      margin: REdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: FlutterMap(
          key: ValueKey("$lat-$lng"),
          options: MapOptions(
            initialCenter: LatLng(lat, lng),
            initialZoom: 15,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.none,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.moona.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(lat, lng),
                  width: 40.w,
                  height: 40.h,
                  child: Icon(
                    Icons.location_pin,
                    size: 40.sp,
                    color: ColorsManager.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
