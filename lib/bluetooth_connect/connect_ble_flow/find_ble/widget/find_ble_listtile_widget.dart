import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../blue_provider.dart';

class BleListTileWidget extends StatelessWidget {
  const BleListTileWidget(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueProvider>(context);
    var data = provider.bleDevices[index].device;
    return ListTile(
      onTap: () {

      },
      title: Text('${data.name ?? '알 수 없는 기기'}'),
      trailing: Text(provider.setBondedText(data.isBonded)),
    );
  }
}
