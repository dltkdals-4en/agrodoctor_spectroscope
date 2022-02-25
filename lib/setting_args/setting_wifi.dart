import 'package:ctgformanager/bluetoothConnect/args_setting_provider.dart';
import 'package:ctgformanager/bluetoothConnect/blue_serial_provider.dart';
import 'package:ctgformanager/bluetoothConnect/sensor_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingWifi extends StatefulWidget {
  const SettingWifi({Key? key}) : super(key: key);

  @override
  _SettingWifiState createState() => _SettingWifiState();
}

class _SettingWifiState extends State<SettingWifi> {
  TextEditingController ssidText = TextEditingController();
  TextEditingController sspwText = TextEditingController();
  FocusNode ssidFocus = FocusNode();
  FocusNode sspwFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    ssidText;
    sspwText;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ssidText.dispose();
    sspwText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueSerialProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('와이파이 상세 관리'),
        actions: [
          IconButton(
              onPressed: () {
                provider.setWifi(ssidText.text, sspwText.text);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
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
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            'ssid:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: ssidText,
                              focusNode: ssidFocus,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  hintText: (provider.wifiSsid == '')
                                      ? 'no data'
                                      : provider.wifiSsid,
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      ssidFocus.requestFocus();
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            'sspw:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: sspwText,
                              focusNode: sspwFocus,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  hintText: (provider.wifiSspw == '')
                                      ? 'no data'
                                      : provider.wifiSspw,
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      sspwFocus.requestFocus();
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
