import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothListTile extends ListTile {
  BluetoothListTile({
    required BluetoothDevice device,
    int? rssi,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    bool enabled = true,
  }) : super(
          onTap: onTap,
          onLongPress: onLongPress,
          enabled: enabled,
          title: Text(
            device.name ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          subtitle: Text(
            device.address.toString(),
            style: TextStyle(fontSize: 16),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // rssi != null
              //     ? Container(
              //         margin: new EdgeInsets.all(8.0),
              //         child: DefaultTextStyle(
              //           style: _computeTextStyle(rssi),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: <Widget>[
              //               Text(rssi.toString()),
              //               Text('dBm'),
              //             ],
              //           ),
              //         ),
              //       )
              //     : Container(width: 0, height: 0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('페어링 : '),
                      device.isBonded
                          ? Text('O')
                          : Text('X'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('연결:'),
                      device.isConnected ? Text('connected') : Text('disconnected'),
                    ],
                  ),
                ],
              ),

            ],
          ),
        );

  static TextStyle _computeTextStyle(int rssi) {
    /**/ if (rssi >= -35)
      return TextStyle(color: Colors.greenAccent[700]);
    else if (rssi >= -45)
      return TextStyle(
          color: Color.lerp(
              Colors.greenAccent[700], Colors.lightGreen, -(rssi + 35) / 10));
    else if (rssi >= -55)
      return TextStyle(
          color: Color.lerp(
              Colors.lightGreen, Colors.lime[600], -(rssi + 45) / 10));
    else if (rssi >= -65)
      return TextStyle(
          color: Color.lerp(Colors.lime[600], Colors.amber, -(rssi + 55) / 10));
    else if (rssi >= -75)
      return TextStyle(
          color: Color.lerp(
              Colors.amber, Colors.deepOrangeAccent, -(rssi + 65) / 10));
    else if (rssi >= -85)
      return TextStyle(
          color: Color.lerp(
              Colors.deepOrangeAccent, Colors.redAccent, -(rssi + 75) / 10));
    else
      /*code symmetry*/
      return TextStyle(color: Colors.redAccent);
  }
}
