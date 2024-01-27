import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Widgets Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello, Flutter!'),
              ElevatedButton(
                onPressed: () {
                  // ทำอะไรบางอย่าง
                },
                child: Text('Press Me'),
              ),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                child: Text('Inside Container'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Left'),
                  Text('Right'),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                  Text('On top of Container'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
