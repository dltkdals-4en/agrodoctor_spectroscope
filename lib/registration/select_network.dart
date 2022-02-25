import 'package:ctgformanager/registration/external_device_setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectNetwork extends StatelessWidget {
  const SelectNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('네트워크 선택'),
        actions: [Icon(Icons.help_rounded)],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 100,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 8.0, left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '새 기기 등록하기',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '연결할 네트워크를 선택해주세요.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExternalDeviceSettingScreen(),
                    ));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: size.width * 0.9,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.wifi,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Wifi로 연결하기',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text('한번에 5개의 기기까지 연동할 수 있습니다.',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
