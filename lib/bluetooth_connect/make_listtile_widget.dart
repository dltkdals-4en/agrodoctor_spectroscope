import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class MakeListTileWidget extends ListTile {
  MakeListTileWidget({
    required BluetoothDevice device,
    GestureTapCallback? onTap,

  }) : super(
          onTap: onTap,
          title: Text('title'),

        );
}
