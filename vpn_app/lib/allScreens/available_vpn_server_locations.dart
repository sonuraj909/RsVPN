import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allControllers/controller_vpn_location.dart';
import 'package:vpn_basic_project/allWidget/vpn_location_card_widget.dart';
import 'package:vpn_basic_project/main.dart';

class AvailableVpnServerLocations extends StatelessWidget {
  AvailableVpnServerLocations({super.key});

  final vpnLocationController = ControllerVpnLocation();

  loadingUIWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Finding Free VPN Locations...",
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
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor2,
          title: Text(
            "Available Locations (" +
                vpnLocationController.vpnFreeServerAvailablelist.length
                    .toString() +
                ")",
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
            bottom: 10,
            right: 10,
          ),
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(169, 106, 106, 106),
            onPressed: () {
              vpnLocationController.retrieveVpnInformation();
            },
            child: Icon(
              CupertinoIcons.refresh_circled_solid,
              color: Colors.redAccent,
            ),
          ),
        ),
        body: vpnLocationController.isLoadingNewLocations.value
            ? loadingUIWidget()
            : vpnLocationController.vpnFreeServerAvailablelist.isEmpty
                ? noVpnServerFoundUIWidget()
                : vpnAvailableServersData(),
      ),
    );
  }
}
