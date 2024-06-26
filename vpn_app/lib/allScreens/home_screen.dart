import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/appPreferences/app_preferences.dart';
import 'package:vpn_basic_project/main.dart';

import '../allWidget/custom_round_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  locationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {},
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
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey,
                ),
                child: Container(
                  width: sizeScreen.width * .14,
                  height: sizeScreen.height * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
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
          "Tap to Connect",
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
    sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("DevVPN"),
        leading: IconButton(
          onPressed: () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomRoundWidget(
                titleText: "Location",
                subTitleText: "Free",
                roundIconWiget: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.redAccent,
                  child: Icon(
                    Icons.flag_circle_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomRoundWidget(
                titleText: "60 ms",
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
          //VPN
          vpnRoundButton(),
          //download & ping

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomRoundWidget(
                titleText: "0 kbps",
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
                titleText: "0 mbps",
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
          )
        ],
      ),
    );
  }
}
