
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan QRCode Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home:  const ScanQRCode1.ScanQRCode(title: 'Scan QRCode Demo(qrscan)'),
      //home:  const ScanQRCode1.ScanQRCode(title: 'Scan QRCode Demo(flutter_barcode)'),
      home:  const ScanQRCode(title: 'Scan QRCode Demo(AI)'),
      //home:  ScanBarcode(),
    );
  }
}




class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key, required this.title});

  final String title;

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class SData {
  String data;
  DateTime datetime;

  SData(this.data, this.datetime);
}

class _ScanQRCodeState extends State<ScanQRCode> {
  //String scanData = "";
  List<SData> listData = [];
  TextEditingController _textFieldController = TextEditingController();
  bool isBarcode = false;
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(children: [
        TextField(
          controller: _textFieldController,
          decoration: InputDecoration(
              labelText: 'ป้อนข้อความ',
              suffixIcon: IconButton(
                icon: Icon(isBarcode ? Icons.barcode_reader : Icons.keyboard),
                onPressed: () {
                  setState(() {
                    isBarcode = !isBarcode;
                  });
                  // Do something
                },
              )),
          autofocus: true,
          keyboardType: (isBarcode ? TextInputType.none : TextInputType.text),
          focusNode: myFocusNode,
          onSubmitted: (text) {
            if (text != "") {
              listData.insert(0, SData(text, DateTime.now()));
            }
            _textFieldController.clear();
            myFocusNode.requestFocus();

            setState(() {});
          },
        ),
        Expanded(
            child: ListView(
          children: listData.map((item) => ListItem(item)).toList(),
        ))
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: scanOnPressed,
        tooltip: 'scan',
        child: const Icon(Icons.qr_code),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  scanOnPressed() async {
    await Permission.camera.request();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AiBarcodeScanner(
          /* validator: (value) {
                        return value.startsWith('https://');
                      }, */
          canPop: false,
          onScan: (String value) {
            debugPrint(value);
            setState(() {
              listData.insert(0, SData(value, DateTime.now()));
            });
            Navigator.pop(context);
           
          },
          onDetect: (p0) {},
          onDispose: () {
            debugPrint("Barcode scanner disposed!");
          },
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
          ),
        ),
      ),
    );
  }

  Widget ListItem(SData item) {
    return ListTile(
      title: Text(item.data),
      subtitle: Text(item.datetime.toString(), style: TextStyle(fontSize: 10)),
    );
  }
}
