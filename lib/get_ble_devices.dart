import 'package:ctgformanager/ble_scanning_page.dart';
import 'package:ctgformanager/contstants/loading_page.dart';
import 'package:ctgformanager/contstants/loading_widget.dart';
import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:ctgformanager/test_protocol_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contstants/constants.dart';
import 'contstants/screen_size.dart';

class GetBleDevices extends StatelessWidget {
  const GetBleDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bleProvider = Provider.of<BleProvider>(context);
    if (!bleProvider.findBleDevices) {
      bleProvider.scanBle();
      return LoadingPage('블루투스 스캔 중이에요...');
    } else {
      return BleScanningPage();
    }
  }
}
