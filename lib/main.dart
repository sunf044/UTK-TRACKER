import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

void checklocationPermission() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'UTK TRACKER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String _status = "";
  static String _perm = "";
  var location = "กดเพื่อเช็ค";
  late bool position;
  late LocationPermission permission;
  // ignore: non_constant_identifier_names
  late Position Curpo;

  _MyHomePageState() {
    check();
  }

  getlocation() async {
    check();
    Curpo = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  void check() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _perm = "ไม่อนุญาต";
        });
      } else {
        setState(() {
          _perm = "อนุญาต";
        });
      }
    } else {
      setState(() {
        _perm = "อนุญาต";
      });
    }

    position = await Geolocator.isLocationServiceEnabled();
    if (position) {
      setState(() {
        _status = "เปิดอยู่";
      });
    } else {
      setState(() {
        _status = "ปิดอยู่";
      });
    }
  }

  Widget buttontest() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF1A8745)),
      ),
      onPressed: getlocation,
      child: Text(
        'GET',
        style: TextStyle(color: Color(0xFFffffff)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const IconButton(
          icon: Icon(
            Icons.menu,
            color: Color(0xFF1A8745),
          ),
          onPressed: null,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Color(0xFF1A8745),
            fontFamily: 'Mitr',
          ),
        ),
        backgroundColor: Color(0xFFffffff),
        elevation: 0.0,
        shadowColor: Color(0xFFffffff),
      ),
      backgroundColor: Color(0xFFffffff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'GPS $_status',
              style: TextStyle(
                color: Color(0xFF1A8745),
                fontFamily: 'Mitr',
              ),
            ),
            Text(
              '$_perm',
              style: Theme.of(context).textTheme.headline4,
            ),
            buttontest(),
          ],
        ),
      ),
    );
  }
}
