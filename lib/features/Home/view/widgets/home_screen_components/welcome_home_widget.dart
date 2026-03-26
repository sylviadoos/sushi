import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../main.dart';
import '../../../../../routes/app_routes.dart';

class WelcomeHomeWidget extends StatelessWidget {
  GoogleMapController? mapController;

  // ignore: use_setters_to_change_properties
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(26.2028629, 50.56517040000001),
          zoom: 11,
        ),
        // markers: Set<Marker>.of(logic.markers.values),
      ),
    );
  }
}
