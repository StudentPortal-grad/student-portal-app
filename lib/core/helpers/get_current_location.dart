/*
import 'package:geolocator/geolocator.dart';
import 'package:goalak_app/core/helpers/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

import '../utils/app_toast.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) await PermissionManager.askForPermission(Permission.location);
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) AppToast.toast(msg: 'Please Enable Location');

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      AppToast.toast(msg: 'Location Permission Denied');
    }
  }
  return await Geolocator.getCurrentPosition();
}

Future<String> getAddress({double? lat, double? long}) async {
  Position? location;
  if(lat == null && long == null){
    location = await getCurrentLocation();
  }
  lat ??= location?.latitude;
  long ??= location?.longitude;

  if(lat == null || long == null) return '';
  var addresses = await placemarkFromCoordinates(lat, long);
  var first = addresses.first;
  String address = '';
  // if(first.subThoroughfare?.isNotEmpty ?? false) address += '${first.subThoroughfare}, ';
  // if(first.thoroughfare?.isNotEmpty ?? false) address += '${first.thoroughfare}, ';
  // if(first.subLocality?.isNotEmpty ?? false) address += '${first.subLocality}, ';
  // if(first.locality?.isNotEmpty ?? false) address += '${first.locality}, ';
  if(first.subAdministrativeArea?.isNotEmpty ?? false) address += '${first.subAdministrativeArea}, ';
  // if(first.administrativeArea?.isNotEmpty ?? false) address += '${first.administrativeArea}, ';
  if(first.country?.isNotEmpty ?? false) address += '${first.country}';
  return address;
}
*/
