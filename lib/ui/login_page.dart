import 'package:flutter/material.dart';
import 'package:responsi_kesehatan/bloc/catatan_aktivitas_fisik_bloc.dart';
import 'package:responsi_kesehatan/bloc/login_bloc.dart';
import 'package:responsi_kesehatan/widget/warning_dialog.dart';
import 'package:responsi_kesehatan/ui/catatan_aktivitas_fisik_page.dart';
import 'package:responsi_kesehatan/ui/registrasi_page.dart';

class CatatanAktivitasLoginPage extends StatefulWidget {
  const CatatanAktivitasLoginPage({Key? key}) : super(key: key);

  @override
  _CatatanAktivitasLoginPageState createState() =>
      _CatatanAktivitasLoginPageState();
}

class _CatatanAktivitasLoginPageState extends State<CatatanAktivitasLoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Catatan Aktivitas Fisik',
          style: TextStyle(fontFamily: 'Helvetica', fontSize: 20),
        ),
        backgroundColor: Colors.yellow[700], // Warna kuning terang
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.yellow[50], // Latar belakang kuning terang yang lembut
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Silakan Masukkan Data Anda",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _emailTextField(),
                  const SizedBox(height: 20),
                  _passwordTextField(),
                  const SizedBox(height: 30),
                  _buttonLogin(),
                  const SizedBox(height: 20),
                  _menuRegistrasi()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(
          fontFamily: 'Helvetica',
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.yellow, // Border warna kuning
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.orange, // Warna border saat fokus
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Helvetica'),
    );
  }

  // Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(
          fontFamily: 'Helvetica',
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.yellow, // Border warna kuning
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.orange, // Warna border saat fokus
            width: 2.0,
          ),
        ),
      ),
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Helvetica'),
    );
  }

  // Membuat Tombol Login
  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[700], // Warna tombol lebih gelap
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Tombol lebih melengkung
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: const Text(
        "Login",
        style: TextStyle(fontFamily: 'Helvetica', fontSize: 18),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) {
      if (value.code == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CatatanAktivitasFisikPage()));
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  // Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Helvetica',
            fontSize: 16,
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
