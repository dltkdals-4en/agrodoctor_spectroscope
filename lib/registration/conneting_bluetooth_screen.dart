import 'package:ctgformanager/registration/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class ConnectingBluetoothScreen extends StatefulWidget {
  const ConnectingBluetoothScreen({Key? key}) : super(key: key);

  @override
  _ConnectingBluetoothScreenState createState() =>
      _ConnectingBluetoothScreenState();
}

class _ConnectingBluetoothScreenState extends State<ConnectingBluetoothScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var data = Provider.of<BluetoothProvider>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text('기기 찾기'),
            actions: [
              IconButton(
                  onPressed: () {
                    data.scan();
                    print('222 ${data.blueDeviceList}');
                  },
                  icon: Icon(Icons.refresh))
            ],
            bottom: PreferredSize(
              child: Container(
                color: Colors.green,
                height: 150,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 8.0, left: 8.0, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.title}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // Text(
                      //   '연결된 기기 ${value.count} / 5',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //   ),
                      // ),
                      data.info(),
                    ],
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(150),
            )),
        body: (data.blueDeviceList.length == 0)
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Container(
                      width: size.width,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('기기 찾기'),
                            ElevatedButton(
                              onPressed: () {
                                data.scan();
                              },
                              child: Text('찾기'),
                            ),
                          ],
                        ),
                      )),
                ))
            : ListView.builder(
                itemBuilder: (context, index) {
                  var r = data.blueDeviceList[index];
                  return InkWell(
                    onTap: () {
                      print(r.device.state.isBroadcast);
                      data.connectingBluetooth(r);
                    },
                    child: Card(
                      child: Container(
                          width: size.width,
                          height: 100,
                          child: Row(
                            children: [
                              leading(r),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      deviceName(r),
                                      deviceMacAddress(r),
                                      deviceType(r),
                                      data.deviceState(r)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                  ListTile(
                    onTap: () {},
                    leading: leading(r),
                    title: deviceName(r),
                    subtitle: Column(
                      children: [
                        // deviceMacAddress(r),
                        Text('${r.device.id.id}'),
                        Text('${r.device.type}'),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        data.deleteItem(r);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
                itemCount: data.listlength,
              ));
  }
}

Widget deviceSignal(ScanResult r) {
  return Text(r.rssi.toString());
}

/* 장치의 MAC 주소 위젯  */
Widget deviceMacAddress(ScanResult r) {
  return Text('기기 아이디: ${r.device.id.id}');
}

Widget deviceType(ScanResult r) {
  return Text('기기 타입: ${r.device.type}');
}

/* 장치의 명 위젯  */
Widget deviceName(ScanResult r) {
  String name = '';

  if (r.device.name.isNotEmpty) {
    // device.name에 값이 있다면
    name = r.device.name;
  } else if (r.advertisementData.localName.isNotEmpty) {
    // advertisementData.localName에 값이 있다면
    name = r.advertisementData.localName;
  } else {
    // 둘다 없다면 이름 알 수 없음...
    name = 'N/A';
  }
  return Text(
    name,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );
}

/* BLE 아이콘 위젯 */
Widget leading(ScanResult r) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CircleAvatar(
      child: Icon(
        Icons.bluetooth,
        color: Colors.white,
      ),
      backgroundColor: Colors.cyan,
    ),
  );
}

/* 장치 아이템을 탭 했을때 호출 되는 함수 */
void onTap(ScanResult r) {


  // 단순히 이름만 출력
  print('${r.device.name}');
}
