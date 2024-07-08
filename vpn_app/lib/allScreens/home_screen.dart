import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allControllers/controller_home.dart';

import 'package:vpn_basic_project/allModels/vpn_status.dart';
import 'package:vpn_basic_project/allScreens/available_vpn_server_locations.dart';
import 'package:vpn_basic_project/allScreens/connected_network_ip_info.dart';
import 'package:vpn_basic_project/allWidget/timer_widget.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';

import 'package:vpn_basic_project/appPreferences/app_preferences.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/vpnEngine/vpn_engine.dart';

import '../allWidget/custom_round_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(ControllerHome());

  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            ApiVpnGate.retrieveAllAvailableFreeVpnServers();
            Get.to(() => AvailableVpnServerLocations());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.04),
            height: 62,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  size: 36,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Select Country/ Location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Theme.of(context).iconColor,
                    size: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: sizeScreen.height * .03, bottom: sizeScreen.height * .02),
          padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
          child: Text(
            "STATUS: ${homeController.vpnConnectionState.value == VpnEngine.vpnDisconnectedNow ? "Not Connected" : homeController.vpnConnectionState.replaceAll("_", " ").toUpperCase()}",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(() => TimerWidget(
            initTimerNow: homeController.vpnConnectionState.value ==
                VpnEngine.vpnConnectedNow)),
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {
              homeController.connectToVpnNow();
            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: homeController.getRoundVpnButtonColor.withOpacity(.1),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundVpnButtonColor.withOpacity(.3),
                ),
                child: Container(
                  width: sizeScreen.width * .14,
                  height: sizeScreen.height * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundVpnButtonColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          homeController.getRoundVpnButtonText,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;
    });
    sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("DEVVPN"),
        leading: IconButton(
          onPressed: () {
            Get.to(() => ConnectedNetworkIpInfo());
          },
          icon: Icon(Icons.perm_device_info_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark);
              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
            icon: Icon(Icons.brightness_2_rounded),
          )
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNavigation(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //loc & ping
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoundWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "Location"
                          : homeController.vpnInfo.value.countryLongName,
                  subTitleText: "Free",
                  roundIconWiget: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.redAccent,
                    child: homeController.vpnInfo.value.countryLongName.isEmpty
                        ? Icon(
                            Icons.flag_circle_rounded,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                    backgroundImage: homeController
                            .vpnInfo.value.countryLongName.isEmpty
                        ? null
                        : AssetImage(
                            "assets/countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png"),
                  ),
                ),
                CustomRoundWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "60 ms"
                          : "${homeController.vpnInfo.value.ping} ms",
                  subTitleText: "Ping",
                  roundIconWiget: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.graphic_eq,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //download & ping
          StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.snapshotVpnStatus(),
              builder: (context, dataSnapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundWidget(
                      titleText: "${dataSnapshot.data?.byteIn ?? '0 kbps'}",
                      subTitleText: "Downloads",
                      roundIconWiget: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.greenAccent,
                        child: Icon(
                          Icons.arrow_circle_down_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustomRoundWidget(
                      titleText: "${dataSnapshot.data?.byteOut ?? '0 kbps'}",
                      subTitleText: "Upload",
                      roundIconWiget: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.yellowAccent,
                        child: Icon(
                          Icons.arrow_circle_up_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }),
          //VPN
          Obx(() => vpnRoundButton()),
        ],
      ),
    );
  }
}
