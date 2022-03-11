import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/make_listtile_widget.dart';
import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/loading_screen.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'find_ble_listtile_widget.dart';

class FindBleListViewWidget extends StatelessWidget {
  const FindBleListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<BlueProvider>(context);
    if (provider.bleDiscovering == true) {
      return LoadingScreen();
    } else {
      return Expanded(
        child: ListView.separated(
          itemCount: provider.bleDevices.length,
          itemBuilder: (context, index) {
            return MakeListTileWidget(
              context: context,
              index: index,
              TileData: TileData.BLE,
              onTap: () {},
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: SMALLGAP,
            );
          },
        ),
      );
    }
  }
}
