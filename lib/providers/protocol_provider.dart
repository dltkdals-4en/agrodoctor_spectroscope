import 'package:flutter/material.dart';

class ProtocolProvider with ChangeNotifier {
  TextEditingController anyProtocol = TextEditingController();
  String bleConnected = "연결 안됨";
  String inputText = "입력값이 없습니다.";
  void setBleConnectedText(bool connected){
    if(connected){
      bleConnected = "연결됨";

    }else{
      bleConnected = "연결안됨";
    }
  }
  void inputProtocol(String str){
    inputText = str;
    notifyListeners();
  }
  String outputText = "출력값이 없습니다.";
  void outputProtocol(String str){
    outputText = str;
    notifyListeners();
  }
}
