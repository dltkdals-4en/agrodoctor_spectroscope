import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

class MakeListTileWidget extends ListTile {
  MakeListTileWidget({
    required TileData,
    required int index,
    required BuildContext context,
    GestureTapCallback? onTap,
  }) : super(
          onTap: onTap,
          title: Text(titleText(TileData, context, index)),
          subtitle: Text(
            subTitleText(TileData, context, index),
            style: makeTextStyle(14, AppColors.blackGrey, 'regular'),
          ),
          trailing: trailingWidget(TileData, context, index),
        );

  static String titleText(tileData, context, index) {
    var provider = Provider.of<BlueProvider>(context);
    switch (tileData) {
      case TileData.BLE:
        var data = provider.bleDevices[index].device;
        return data.name!;

      case TileData.PAIRING:
        var data = provider.pairingDevices[index];
        return data.name!;
      case TileData.WIFI:
        var data = provider.wifiList[index];
        return data.ssid!;
      default:
        return '';
    }
  }

  static trailingWidget(tileData, BuildContext context, int index) {
    var provider = Provider.of<BlueProvider>(context);

    switch (tileData) {
      case TileData.BLE:
        var data = provider.bleDevices[index].device;
        return Text(provider.setBondedText(data.isBonded));

      case TileData.PAIRING:
        var data = provider.pairingDevices[index];
        return SizedBox();
      case TileData.WIFI:
        var data = provider.wifiList[index];
        return SizedBox();
      default:
        return '';
    }
  }

  static String subTitleText(tileData, BuildContext context, int index) {
    var provider = Provider.of<BlueProvider>(context);
    switch (tileData) {
      case TileData.BLE:
        var data = provider.bleDevices[index].device;
        return data.address;

      case TileData.PAIRING:
        var data = provider.pairingDevices[index];
        return data.address;
      case TileData.WIFI:
        var data = provider.wifiList[index];
        return data.bssid!;
      default:
        return '';
    }
  }
}
