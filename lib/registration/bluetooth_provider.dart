import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothProvider with ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  int count = 0;
  String title = '블루투스 연동하기';
  String btnName = '찾기';
  List<ScanResult> blueDeviceList = [];
  bool _isScanning = false;
  int listlength = 5;



  Widget info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '연결된 기기 ${count} / 5',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        searchState(title),
      ],
    );
  }



  scan() async {
    if (!_isScanning) {
      // 스캔 중이 아니라면
      // 기존에 스캔된 리스트 삭제
      blueDeviceList.clear();
      // 스캔 시작, 제한 시간 4초
      flutterBlue.startScan(timeout: Duration(seconds: 3)).then((value) {
        title = '검색이 완료되었습니다.';

        notifyListeners();
      });
      // 스캔 결과 리스너
      flutterBlue.scanResults.listen((results) {
        // List<ScanResult> 형태의 results 값을 scanResultList에 복사
        blueDeviceList = results;
        // blueDeviceList.removeWhere(
        //     (element) => element.device.type == BluetoothDeviceType.unknown);
        listlength = blueDeviceList.length;
        title = '검색 중입니다.';

        count = blueDeviceList.length;

        // UI 갱신
        notifyListeners();
      });
    } else {
      // 스캔 중이라면 스캔 정지
      flutterBlue.stopScan();
    }
  }

  deleteItem(ScanResult r) {
    r.device.disconnect();
    blueDeviceList
        .removeWhere((element) => element.device.id.id == r.device.id.id);
    listlength = blueDeviceList.length;
    count = blueDeviceList.length;
    print(blueDeviceList.length);
    notifyListeners();
  }

  Widget searchState(sState) {
    switch (sState) {
      case '검색 중입니다.':
        return CircularProgressIndicator();
      case '검색이 완료되었습니다.':
        return TextButton(onPressed: () {
          scan();
        }, child: Text('다시 찾기'));
      default:
        return SizedBox.shrink();;
    }
  }
  connectingBluetooth(ScanResult r){
    print('123');
     StreamBuilder(
        stream: r.device.state,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case BluetoothDeviceState.connected:
              r.device.disconnect();
              return Text('연결상태: 연결됨');
            case BluetoothDeviceState.disconnected:
              r.device.connect();
              return Text('연결상태: 연결 안됨');
            default:
              return Text('연결상태: 알 수 없음');
          }
        },
      );

  }
  /* 장치 연결상태 */
  Widget deviceState(ScanResult r) {
    return StreamBuilder(
      stream: r.device.state,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case BluetoothDeviceState.connected:
            return Text('연결상태: 연결됨');
          case BluetoothDeviceState.disconnected:
            return Text('연결상태: 연결 안됨');
          default:
            return Text('연결상태: 알 수 없음');
        }
      },
    );
  }
}
