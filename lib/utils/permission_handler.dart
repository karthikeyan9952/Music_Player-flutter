import 'package:musicplayer/constants/global_objects.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> getStoragePermission() async {
  var status = await Permission.manageExternalStorage.request();
  if (status.isGranted) {
    logger.e("message");
    return;
  } else if (status.isPermanentlyDenied) {
    await openAppSettings();
  }
}
