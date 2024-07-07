import 'package:get/get.dart';
import 'package:vpn_basic_project/allModels/vpn_info.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';
import 'package:vpn_basic_project/appPreferences/app_preferences.dart';

class ControllerVpnLocation extends GetxController {
  List<VpnInfo> vpnFreeServerAvailablelist = AppPreferences.vpnList;
  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInformation() async {
    isLoadingNewLocations.value = true;
    vpnFreeServerAvailablelist.clear();
    vpnFreeServerAvailablelist =
        await ApiVpnGate.retrieveAllAvailableFreeVpnServers();
    isLoadingNewLocations.value = false;
  }
}
