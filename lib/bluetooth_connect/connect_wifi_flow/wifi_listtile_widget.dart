import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/connect_wifi_flow/wifi_input_info.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WifiListTileWidget extends StatelessWidget {
  const WifiListTileWidget(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var wifiData = provider.wifiList[index];
    return ListTile(

      onTap: () {
        provider.setWifiSsid(provider.wifiList[index].ssid!);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WifiInputInfo(wifiData),
            ));
      },
      title: Text('${wifiData.ssid}'),


    );
  }
}

