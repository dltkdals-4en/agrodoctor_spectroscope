import 'package:ctgformanager/registration/select_network.dart';
import 'package:flutter/material.dart';

class RegistScreen extends StatelessWidget {
  const RegistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기기 등록하기'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectNetwork() ,));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Container(
                color: Colors.grey,
              ),
            ),
            ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectNetwork() ,));
            }, child: Text('기기 추가하기')),
          ],
        ),
      ),
    );
  }
}
