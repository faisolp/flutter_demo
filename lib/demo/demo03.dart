import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

// MyApp: วิดเจ็ตหลักของแอปพลิเคชัน
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp: กำหนดโครงสร้างพื้นฐานของแอปพลิเคชัน
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

// MyHomePage: StatefulWidget ที่แสดงหน้าหลักของแอปพลิเคชัน
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // รายการ routes ที่ใช้สำหรับนำทางใน Drawer
  final List<Map<String, dynamic>> routes = [
    {'route': '/home', 'title': 'Home', 'icon': 'home'},
    {'route': '/profile', 'title': 'Profile', 'icon': 'person'},
    // เพิ่ม routes อื่นๆ ที่นี่
  ];

  // _currentWidget: วิดเจ็ตที่แสดงในขณะนี้
  Widget _currentWidget = Home();

  // getPageWidget: ฟังก์ชันสำหรับรับ route และคืนค่าวิดเจ็ตที่เกี่ยวข้อง
  Widget getPageWidget(String route) {
    switch (route) {
      case '/home':
        return Home();
      case '/profile':
        return Profile();
      default:
        return Home();
    }
  }

  // _changePage: ฟังก์ชันสำหรับเปลี่ยนหน้า
  void _changePage(String route) {
    setState(() {
      _currentWidget = getPageWidget(route);
    });
  }

  // getIconData: ฟังก์ชันสำหรับรับชื่อไอคอนและคืนค่า IconData
  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'person':
        return Icons.person;
      // เพิ่ม icons อื่นๆ ที่นี่
      default:
        return Icons.circle; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: โครงสร้างพื้นฐานของหน้าจอ
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Drawer Example'),
      ),
      body: _currentWidget,
      // Drawer: เมนูด้านข้าง
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            AppDrawerHeader(),
            // AppDrawerItems: รายการของเมนูใน Drawer
            AppDrawerItems(routes: routes, onChangePage: _changePage, getIcon: getIconData),
          ],
        ),
      ),
    );
  }
}

// AppDrawerHeader: ส่วนหัวของ Drawer
class AppDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        'Drawer Header',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}

// AppDrawerItems: สร้างรายการของเมนูใน Drawer
class AppDrawerItems extends StatelessWidget {
  final List<Map<String, dynamic>> routes;
  final Function(String) onChangePage;
  final Function(String) getIcon;

  AppDrawerItems({required this.routes, required this.onChangePage, required this.getIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routes.map((route) => DrawerItem(
            title: route['title'],
            iconData: getIcon(route['icon']),
            onTap: () => onChangePage(route['route']),
          )).toList(),
    );
  }
}

// DrawerItem: สร้างแต่ละรายการเมนูใน Drawer
class DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  DrawerItem({required this.title, required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () {
        onTap();
        Navigator.pop(context); // ปิด Drawer เมื่อรายการถูกเลือก
      },
    );
  }
}

// Home: หน้า Home
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

// Profile: หน้า Profile
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}
