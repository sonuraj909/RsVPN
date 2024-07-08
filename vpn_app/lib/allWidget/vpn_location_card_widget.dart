import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allControllers/controller_home.dart';
import 'package:vpn_basic_project/allModels/vpn_info.dart';
import 'package:vpn_basic_project/appPreferences/app_preferences.dart';
import 'package:vpn_basic_project/vpnEngine/vpn_engine.dart';

class VpnLocationCardWidget extends StatelessWidget {
  VpnLocationCardWidget({
    Key? key,
    required this.vpnInfo,
  }) : super(key: key);

  final VpnInfo vpnInfo;

  String formatSpeedBytes(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return "0 Bps";
    }
    const suffixes = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];

    int speedTitleIndex = (log(speedBytes) / log(1024)).floor();
    double value = speedBytes / pow(1024, speedTitleIndex);
    return "${value.toStringAsFixed(decimals)} ${suffixes[speedTitleIndex]}";
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    final homeController = Get.find<ControllerHome>();

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(
          vertical: sizeScreen.height * 0.01,
          horizontal: sizeScreen.height * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          homeController.vpnInfo.value = vpnInfo;
          AppPreferences.VpnInfoObj = vpnInfo;
          Get.back();

          if (homeController.vpnConnectionState.value ==
              VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();
            Future.delayed(
              Duration(seconds: 3),
              () => homeController.connectToVpnNow(),
            );
          } else {
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Image.asset(
              "assets/countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png",
              height: 40,
              width: sizeScreen.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(vpnInfo.countryLongName),
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed_rounded,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                formatSpeedBytes(vpnInfo.speed, 2),
                style: TextStyle(
                  fontSize: sizeScreen.width * 0.03,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionName.toString(),
                style: TextStyle(
                  fontSize: sizeScreen.width * 0.03,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
