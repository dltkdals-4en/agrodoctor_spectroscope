import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bluetooth_provider.dart';
import 'conneting_bluetooth_screen.dart';

class ExternalDeviceSettingScreen extends StatelessWidget {
  const ExternalDeviceSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('기기 설정하기'),
      ),
      body: Column(
        children: [
          Container(
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
                    '외부 기기의 설정을 해주세요',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '설정 간단 설명 Text',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.orange,
                    width: size.width * 0.9,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1} Title',
                            style: TextStyle(fontSize: 22),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white10,
                              child: Text('설명 공간'),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                'https://picsum.photos/200/300',
                                width: (size.width - 40) * 0.5,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                              Image.network('https://picsum.photos/200/300',
                                  width: (size.width - 40) * 0.5,
                                  height: 100,
                                  fit: BoxFit.fill),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

           ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConnectingBluetoothScreen(),
                    ));
              },
              child: SizedBox(
                width: size.width,
                height: 50,
                child: Center(
                    child: Text(
                  '시작하기',
                  style: TextStyle(fontSize: 20),
                )),
              ),
            ),

        ],
      ),
    );
  }
}
