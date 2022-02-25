import 'package:ctgformanager/bluetoothConnect/args_setting_provider.dart';
import 'package:ctgformanager/bluetoothConnect/blue_serial_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingButtons extends StatefulWidget {
  const SettingButtons(this.fanSpeedList, {Key? key}) : super(key: key);
  final List<int> fanSpeedList;
  @override
  _SettingButtonsState createState() => _SettingButtonsState();
}

class _SettingButtonsState extends State<SettingButtons> {
  TextEditingController tapUrlController = TextEditingController();
  TextEditingController doubleTapUrlController = TextEditingController();
  TextEditingController holdUrlController = TextEditingController();
  FocusNode tapUrlFocus = FocusNode();
  FocusNode doubleTapUrlFocus = FocusNode();
  FocusNode holdUrlFocus = FocusNode();
  List fanSpeeds = [1, 2, 3];
  List urlList = [];



  @override
  void initState() {
    // TODO: implement initState
    tapUrlController;
    doubleTapUrlController;
    holdUrlController;
    insertList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tapUrlController.dispose();
    doubleTapUrlController.dispose();
    holdUrlController.dispose();
    super.dispose();
  }

  insertList() {
    urlList.add({'url': tapUrlController, 'focus': tapUrlFocus, 'selected': widget.fanSpeedList[0]});
    urlList.add({'url': doubleTapUrlController, 'focus': doubleTapUrlFocus, 'selected': widget.fanSpeedList[1]});
    urlList.add({'url': holdUrlController, 'focus': holdUrlFocus, 'selected': widget.fanSpeedList[2]});
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BlueSerialProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('스마트 버튼 관리'),
        actions: [
          IconButton(
              onPressed: () {
                provider.setAux(urlList);
                print(tapUrlController.value);

                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '버튼 정보',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                          child: buttonArgs(size, provider, index));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buttonArgs(Size size, BlueSerialProvider provider, int index) {
    var urlString = 'url${index + 1}';
    print(provider.urlStringList[index]);
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              child: Text(
                '버튼 ${index + 1}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 50,
            //       child: Text(
            //         '팬 속도',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     SizedBox(
            //       height: 40,
            //       child: DropdownButton(
            //         value: urlList[index]['selected'],
            //         items: fanSpeeds.map((value) {
            //           return DropdownMenuItem(
            //             child: Text('${value}'),
            //             value: value,
            //           );
            //         }).toList(),
            //         onChanged: (value) {
            //           setState(() {
            //             urlList[index]['selected'] =
            //                 int.parse(value.toString());
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),

            SizedBox(

              child: TextField(
                controller: urlList[index]['url'],
                focusNode: urlList[index]['focus'],
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintMaxLines: 2,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintStyle:
                        TextStyle(fontSize: 16, color: Colors.black),
                    hintText: provider.urlStringList[index].trim(),
                    suffixIcon: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        urlList[index]['focus'].requestFocus();
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 16,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
