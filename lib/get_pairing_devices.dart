import 'package:ctgformanager/get_ble_devices.dart';
import 'package:ctgformanager/pairing_list_page.dart';
import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contstants/loading_page.dart';

class GetPairingDevices extends StatelessWidget {
  const GetPairingDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bleProvider = Provider.of<BleProvider>(context);
    if (!bleProvider.findPairingDevices) {
      bleProvider.getPairingList();
      return LoadingPage('페어링된 기기 스캔 중이에요...');
    } else {
      if(bleProvider.pairingDevices.length == 0){
        return GetBleDevices();
      }else{
        return PairingListPage();
      }

    }
  }
}
