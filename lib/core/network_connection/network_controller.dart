import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  Connectivity connectivity = Connectivity();
  final RxString connectStatus = ''.obs;
  String? previousRoute;

  @override
  void onInit() {
    connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
    super.onInit();
  }

  void _updateConnectivityStatus(
      List<ConnectivityResult> connectivityResultList) {
    if (connectivityResultList.contains(ConnectivityResult.mobile) ||
        connectivityResultList.contains(ConnectivityResult.wifi)) {
      connectStatus.value = "Internet connected";

      if (previousRoute != null) {
        Get.offNamed(previousRoute!);
        previousRoute = null; // Clear the previous route after navigating back
      }
    } else if (connectivityResultList.contains(ConnectivityResult.none)) {
      connectStatus.value = "OFFLINE";
      previousRoute = Get.currentRoute;
      Get.toNamed('/NoInternetPage');
    } else if (connectivityResultList.contains(ConnectivityResult.other)) {
      connectStatus.value = "OTHER";
    } else {
      connectStatus.value = "Something went wrong";
    }
  }
}
