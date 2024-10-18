import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import '/ui/catatan_aktivitas_fisik_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const CatatanAktivitasFisikPage();
      });
    } else {
      setState(() {
        page = const CatatanAktivitasLoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kesehatan Catatan Aktivitas Fisik',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
