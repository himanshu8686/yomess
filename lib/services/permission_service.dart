import 'package:permission_handler/permission_handler.dart';

class PermissionService{

  /**
   *
   */
  Future<bool> requestAllPermission() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> results = await [
      Permission.location,
      Permission.contacts,
    ].request();

  }
}