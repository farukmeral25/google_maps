// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_location/feature/_feature_exports.dart';
import 'package:google_maps_location/core/_core_exports.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.8999, 29.1936),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    ScreenSize().screenSize = MediaQuery.of(context).size;
    return Scaffold(body: Consumer<UserLocationProvider>(
      builder: (context, UserLocationProvider userLocationProvider, child) {
        return Stack(
          children: [
            _buildGoogleMap(userLocationProvider, context),
            _buildContainerCard(userLocationProvider),
          ],
        );
      },
    ));
  }

  Widget _buildGoogleMap(UserLocationProvider userLocationProvider, BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        userLocationProvider.mapController = controller;
        userLocationProvider.fetchLocationData(context);
      },
      onTap: (argument) {
        userLocationProvider.infoCardVisibility = false;
      },
      markers: userLocationProvider.mapMarkers,
      myLocationButtonEnabled: false,
    );
  }

  Widget _buildContainerCard(UserLocationProvider userLocationProvider) {
    return Visibility(
      visible: userLocationProvider.infoCardVisibility,
      child: Positioned(
        bottom: 10,
        right: 10,
        left: 10,
        child: Container(
          height: 250,
          width: ScreenSize().getWidthPercent(.9),
          decoration: BoxDecoration(
            color: AppColors.saltWhite,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Container ${userLocationProvider.selectedLocationData?.containerId.toString() ?? ""}",
                  style: AppTextStyles.openSansExtraBold20Pt.copyWith(
                    color: AppColors.darkBlue,
                  ),
                ),
                Text(
                  "Next Collection",
                  style: AppTextStyles.openSansBold20Pt.copyWith(
                    color: AppColors.softGrey,
                  ),
                ),
                Text(
                  DateUtil().dateToIDayIMonthIYear(date: userLocationProvider.selectedLocationData?.dateTime),
                  style: AppTextStyles.openSansRegular16Pt.copyWith(
                    color: AppColors.softGrey,
                  ),
                ),
                Text(
                  "Fullness Rate",
                  style: AppTextStyles.openSansBold20Pt.copyWith(
                    color: AppColors.softGrey,
                  ),
                ),
                Text(
                  "% ${userLocationProvider.selectedLocationData?.solidityRatio.toString() ?? ""}",
                  style: AppTextStyles.openSansRegular16Pt.copyWith(
                    color: AppColors.softGrey,
                  ),
                ),
                _buildButtonInContainer(userLocationProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonInContainer(UserLocationProvider userLocationProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppFilledButton(
          text: "Navigate",
          onTap: () {
            launch(
              'https://www.google.com/maps/search/?api=1&query=${userLocationProvider.selectedLocationData?.lat},${userLocationProvider.selectedLocationData?.lon}',
            );
          },
        ),
        AppFilledButton(
          text: "ReLocate",
          onTap: () {
            userLocationProvider.reLocate();
          },
        ),
      ],
    );
  }
}
