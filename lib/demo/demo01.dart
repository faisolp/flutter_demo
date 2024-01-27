import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp: StatelessWidget ที่เป็นจุดเริ่มต้นของแอปพลิเคชัน
//StatelessWidget ประเภทของ Widget ที่ไม่มีสถานะภายใน (state) ที่เปลี่ยนแปลงได้.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: วิดเจ็ตที่กำหนดโครงสร้างพื้นฐานของแอปพลิเคชัน
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // MyHomePage: หน้าแรกของแอปพลิเคชัน
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
//======================================================
// MyHomePage: StatefulWidget ที่แสดงหน้าหลักของแอปพลิเคชัน
//StatefulWidget ประเภทของ Widget ที่มีสถานะภายใน (state) ที่สามารถเปลี่ยนแปลงได้.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  //เมธอด createState มีหน้าที่สร้างและคืนค่าอินสแตนซ์ของ State ที่เกี่ยวข้องกับ StatefulWidget
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
//จะเก็บ state และจัดการข้อมูลหรือสถานะที่เปลี่ยนแปลงได้ภายใน 
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // _incrementCounter: ฟังก์ชันเพิ่มค่า counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: โครงสร้างพื้นฐานของหน้าจอ
    return Scaffold(
      // CustomAppBar: แถบแอปพลิเคชันที่กำหนดเอง
      appBar: CustomAppBar(title: widget.title),
      // Center: วิดเจ็ตที่จัดวางเนื้อหาตรงกลาง
      body: Center(
        // CounterDisplay: แสดงจำนวนครั้งที่กดปุ่ม
        child: CounterDisplay(counter: _counter),
      ),
      // IncrementButton: ปุ่มเพิ่มค่า counter
      floatingActionButton: IncrementButton(onPressed: _incrementCounter),
    );
  }
}
//======================================================

// CustomAppBar: StatelessWidget สำหรับแสดงแถบแอปพลิเคชัน
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// CounterDisplay: StatelessWidget สำหรับแสดงจำนวนครั้งที่กดปุ่ม

class CounterDisplay extends StatelessWidget {
  final int counter;

  const CounterDisplay({Key? key, required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('You have pushed the button this many times:'),
        Text(
          '$counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}

// IncrementButton: StatelessWidget สำหรับปุ่มเพิ่มค่า counter

class IncrementButton extends StatelessWidget {
  final VoidCallback onPressed;

  const IncrementButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
