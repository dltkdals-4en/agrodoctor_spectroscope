import 'package:ctgformanager/contstants/constants.dart';
import 'package:ctgformanager/contstants/screen_size.dart';
import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'device_connect_page.dart';

class PairingListPage extends StatelessWidget {
  const PairingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bleProvider = Provider.of<BleProvider>(context);
    var size = MediaQuery.of(context).size;
    var pairingDevices = bleProvider.pairingDevices;
    return Scaffold(
      appBar: AppBar(
        title: Text('페어링 기기 목록'),
        actions: [
          IconButton(
            onPressed: () {
              bleProvider.initPairingDevices();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.all(NORMALGAP),
                child: Text(
                  '페어링된 기기 수 : ${pairingDevices.length} 개',
                  style: makeTextStyle(18, AppColors.black, 'bold'),
                ),
              ),
              color: AppColors.white,
            ),
            SmH,
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${pairingDevices[index].name}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          bleProvider.setSelectedDivice(pairingDevices[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeviceConnectPage(),
                            ),
                          );
                        },
                        child: Text('설정'),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: pairingDevices.length),
            ),
          ],
        ),
      ),
    );
  }
}
