import 'package:ctgformanager/contstants/loading_widget.dart';
import 'package:ctgformanager/device_connect_page.dart';
import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BleScanningPage extends StatelessWidget {
  const BleScanningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bleProvider = Provider.of<BleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('블루투스 스캔하기'),
        actions: [
          IconButton(
            onPressed: () {
              bleProvider.initBleDevices();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        child: (bleProvider.bleDevices.length == 0)
            ? LoadingWidget()
            : ListView.separated(
                itemCount: bleProvider.bleDevices.length,
                itemBuilder: (context, index) {
                  var device = bleProvider.bleDevices[index].device;
                  return ListTile(
                    title: Text('${device.name ?? "알 수 없는 기기"}'),
                    subtitle: Text((device.isBonded) ? '페어링 O' : '페어링 X'),
                    onTap: () async {
                      bleProvider.selectedIndex = index;
                      if (!device.isBonded) {
                        await bleProvider
                            .devicePairing(device.address)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeviceConnectPage(),
                            ),
                          );
                        });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceConnectPage(),
                          ),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
      ),
    );
  }
}
