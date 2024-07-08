import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allModels/vpn_configuration.dart';
import "package:vpn_basic_project/allModels/vpn_info.dart";
import 'package:vpn_basic_project/appPreferences/app_preferences.dart';
import 'package:vpn_basic_project/vpnEngine/vpn_engine.dart';

class ControllerHome extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.VpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  Future<void> connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationData.isEmpty) {
      Get.snackbar("Location", "Please select the country first.");
      return;
    }
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn =
          Base64Decoder().convert(vpnInfo.value.base64OpenVPNConfigurationData);
      final configuration = Utf8Decoder().convert(dataConfigVpn);
      final vpnConfiguration = VpnConfiguration(
          username: "vpn",
          password: "vpn",
          countryName: vpnInfo.value.countryLongName,
          config: configuration);

      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.green;

      case VpnEngine.vpnConnectedNow:
        return Colors.redAccent;

      default:
        return Colors.orange;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return "Let's Connect Now";

      case VpnEngine.vpnConnectedNow:
        return "Disconnect";

      default:
        return "Connecting...";
    }
  }
}
