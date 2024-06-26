import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';

class CustomRoundWidget extends StatelessWidget {
  const CustomRoundWidget(
      {super.key,
      required this.titleText,
      required this.subTitleText,
      required this.roundIconWiget});

  final String titleText;
  final String subTitleText;
  final Widget roundIconWiget;

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return SizedBox(
      width: sizeScreen.width * .46,
      child: Column(
        children: [
          roundIconWiget,
          const SizedBox(
            height: 7,
          ),
          Text(
            titleText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            subTitleText,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
