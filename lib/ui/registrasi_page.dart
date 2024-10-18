import 'package:flutter/material.dart';
import 'package:responsi_kesehatan/bloc/registrasi_bloc.dart'; // Pastikan jalur ini sesuai dengan struktur folder Anda
import 'package:responsi_kesehatan/widget/success_dialog.dart'; // Pastikan jalur ini sesuai dengan struktur folder Anda
import 'package:responsi_kesehatan/widget/warning_dialog.dart'; // Pastikan jalur ini sesuai dengan struktur folder Anda

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi"),
        backgroundColor:
            Colors.yellow[700], // Warna background AppBar kuning terang
      ),
      body: Container(
        color: Colors.yellow[100], // Warna latar belakang terang kuning
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _namaTextField(),
                  _emailTextField(),
                  _passwordTextField(),
                  _passwordKonfirmasiTextField(),
                  const SizedBox(height: 30),
                  _buttonRegistrasi()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama",
        labelStyle: TextStyle(fontFamily: 'Helvetica'), // Mengatur font
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Helvetica'), // Font input text
    );
  }

  // Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(fontFamily: 'Helvetica'), // Mengatur font
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Helvetica'), // Font input text
    );
  }

  // Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(fontFamily: 'Helvetica'), // Mengatur font
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Helvetica'), // Font input text
    );
  }

  // Membuat textbox Konfirmasi Password
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Konfirmasi Password",
        labelStyle: TextStyle(fontFamily: 'Helvetica'), // Mengatur font
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Helvetica'), // Font input text
    );
  }

  // Membuat Tombol Registrasi
  Widget _buttonRegistrasi() {
    return Container(
      width: double.infinity, // Membuat tombol memenuhi lebar
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[700], // Warna tombol kuning terang
          padding: const EdgeInsets.symmetric(vertical: 15), // Padding tombol
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Registrasi",
                style: TextStyle(fontFamily: 'Helvetica'), // Font tombol
              ),
        onPressed: _isLoading
            ? null
            : () {
                var validate = _formKey.currentState!.validate();
                if (validate) {
                  if (!_isLoading) _submit();
                }
              },
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // Panggil metode registrasi di bloc dengan parameter yang sesuai
    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text,
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SuccessDialog(
          description: "Registrasi berhasil, silahkan login",
          okClick: () {
            Navigator.pop(context);
          },
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Registrasi gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false; // Pastikan untuk mengubah loading status kembali
      });
    });
  }
}
