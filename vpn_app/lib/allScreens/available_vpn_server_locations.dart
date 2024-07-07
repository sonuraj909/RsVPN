import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allControllers/controller_vpn_location.dart';
import 'package:vpn_basic_project/allWidget/vpn_location_card_widget.dart';

class AvailableVpnServerLocations extends StatelessWidget {
  AvailableVpnServerLocations({super.key});

  final vpnLocationController = ControllerVpnLocation();

  loadingUIWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Gathering Free VPN Locations...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  noVpnServerFoundUIWidget() {
    return Center(
      child: Text(
        "No VPNs Found, Try Again.",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  vpnAvailableServersData() {
    return ListView.builder(
        itemCount: vpnLocationController.vpnFreeServerAvailablelist.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(3),
        itemBuilder: (context, index) {
          return VpnLocationCardWidget(
              vpnInfo: vpnLocationController.vpnFreeServerAvailablelist[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnFreeServerAvailablelist.isEmpty) {
      vpnLocationController.retrieveVpnInformation();
    }
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
              "VPN Free Locations {" +
                  vpnLocationController.vpnFreeServerAvailablelist.length
                      .toString() +
                  "}",
            ),
          ),
          body: vpnLocationController.isLoadingNewLocations.value
              ? loadingUIWidget()
              : vpnLocationController.vpnFreeServerAvailablelist.isEmpty
                  ? noVpnServerFoundUIWidget()
                  : vpnAvailableServersData(),
        ));
  }
}
