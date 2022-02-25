import 'package:ctgformanager/bluetoothConnect/blue_serial_provider.dart';
import 'package:ctgformanager/bluetoothConnect/args_setting_provider.dart';
import 'package:ctgformanager/bluetoothConnect/setting_buttons.dart';
import 'package:ctgformanager/setting_args/setting_wifi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

class SensorSettingScreen extends StatefulWidget {
  const SensorSettingScreen(this.device, {Key? key}) : super(key: key);

  final BluetoothDevice device;

  @override
  _SensorSettingScreenState createState() => _SensorSettingScreenState();
}

class _SensorSettingScreenState extends State<SensorSettingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<BlueSerialProvider>(context, listen: false).sendListData();
    });
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   if (Provider
    //       .of<BlueSerialProvider>(context, listen: false)
    //       .isConnected) {
    //     Provider
    //         .of<BlueSerialProvider>(context, listen: false)
    //         .isDisconnecting = true;
    //     Provider
    //         .of<BlueSerialProvider>(context, listen: false)
    //         .connection
    //         ?.dispose();
    //     Provider
    //         .of<BlueSerialProvider>(context, listen: false)
    //         .connection = null;
    //   };
    // });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueSerialProvider>(context);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('4EN 수거센서 관리'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  // blueData.sendData('\$getAuxInfo();');
                  // blueData.sendData('\$getUrlInfo();');
                  // blueData.sendData('\$getWifiInfo();');
                  provider.sendListData();
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  provider.sendData('\$disconnectWifi();');
                  provider.sendData('\$connectWifi();');
                },
                icon: Icon(Icons.save)),
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(
                  '${widget.device.name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '등록된 매장',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '없음',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingWifi(),
                    ));
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '와이파이 정보',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'ssid: ${provider.wifiSsid}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Text(
                            'sspw : ${provider.wifiSspw}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingButtons(provider.fanSpeedList),
                    ));
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '버튼 정보',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: buttonset(provider, index),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.grey,
                                );
                              },
                              itemCount: 3)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buttonset(BlueSerialProvider provider, int index) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '버튼 ${index + 1}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'url 주소: ${provider.urlStringList[index]}',
          style: TextStyle(fontSize: 16),
        ),

        // Text(
        //   '팬속도 : ${provider.fanSpeedList[index]}',
        //   style: TextStyle(fontSize: 16),
        // ),
      ],
    );
  }
}
