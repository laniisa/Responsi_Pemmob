import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import '/ui/catatan_aktivitas_fisik_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> isLogin() async {
    var token = await UserInfo().getToken();
    return token != null; // Return true if token exists
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kesehatan Catatan Aktivitas Fisik',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder<bool>(
            future: isLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading state
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Error state
                return const Text("Terjadi kesalahan. Silahkan coba lagi.");
              } else {
                // Jika berhasil mendapatkan token
                if (snapshot.data == true) {
                  return const CatatanAktivitasFisikPage();
                } else {
                  return const CatatanAktivitasLoginPage();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
