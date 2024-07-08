import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allModels/Ip_info.dart';
import 'package:vpn_basic_project/allModels/network_ip_info.dart';
import 'package:vpn_basic_project/allWidget/network_ip_info_widget.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';

class ConnectedNetworkIpInfo extends StatelessWidget {
  const ConnectedNetworkIpInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final ipInfo = IPInfo.fromJson({}).obs;
    ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "VPN Info",
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
            ipInfo.value = IPInfo.fromJson({});
            ApiVpnGate.retrieveIPDetails(ipInformation: ipInfo);
          },
          child: Icon(
            CupertinoIcons.refresh_circled_solid,
            color: Colors.redAccent,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(10),
          children: [
            //ip info
            NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "IP Address",
                subTitleText: ipInfo.value.query,
                iconData: Icon(Icons.my_location_rounded),
              ),
            ),

            //isp

            NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Internet Service Provider",
                subTitleText: ipInfo.value.internetServiceProvider.isEmpty
                    ? "Unknown"
                    : ipInfo.value.internetServiceProvider,
                iconData: Icon(
                  Icons.account_tree_rounded,
                ),
              ),
            ),

            //location
            NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Location",
                subTitleText: ipInfo.value.countryName.isEmpty
                    ? "Retrieving..."
                    : "${ipInfo.value.cityName},${ipInfo.value.regionName},${ipInfo.value.countryName},",
                iconData: Icon(
                  CupertinoIcons.location_solid,
                ),
              ),
            ),

            //zipcode
            NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Zipcode",
                subTitleText:
                    ipInfo.value.zipCode.isEmpty ? "..." : ipInfo.value.zipCode,
                iconData: Icon(
                  CupertinoIcons.location_solid,
                ),
              ),
            ),

            //timezone
            NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Timezone",
                subTitleText: ipInfo.value.timeZone.isEmpty
                    ? "..."
                    : ipInfo.value.timeZone,
                iconData: Icon(
                  Icons.share_arrival_time_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
