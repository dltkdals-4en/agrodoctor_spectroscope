import 'package:ctgformanager/bluetooth_connect/blue_provider.dart';
import 'package:ctgformanager/bluetooth_connect/connect_ble_flow/pairing_device/pairing_device_widget.dart';
import 'package:ctgformanager/bluetooth_connect/setting_args_page.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WifiComplete extends StatelessWidget {
  const WifiComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('와이파이 연결이 완료되었습니다.'),
            Text('연결된 와이파이: ${provider.wifiSsid}'),
            Text('연결할 기기를 선택해주세요.'),
            Expanded(
                child: ListView.builder(
              itemCount: provider.pairingDevices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      provider
                          .selectDeviceSetting(provider.pairingDevices[index]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingArgsPage(),
                          ));
                    },
                    child: PairingDeviceWidget(provider.pairingDevices[index]));
              },
            ))
          ],
        ),
      ),
    );
  }
}
