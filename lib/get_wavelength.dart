import 'package:ctgformanager/contstants/loading_page.dart';
import 'package:ctgformanager/providers/ble_provider.dart';
import 'package:ctgformanager/providers/chart_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetWavelength extends StatelessWidget {
  const GetWavelength({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bleProvider = Provider.of<BleProvider>(context);
    var chartProvider = Provider.of<ChartDataProvider>(context);

    if(chartProvider.chartX.isEmpty){
      bleProvider.sendData('connectSensor()\r\n');
      return Container();
    }else{
      return LoadingPage('데이터 측정중');
    }

  }
}
