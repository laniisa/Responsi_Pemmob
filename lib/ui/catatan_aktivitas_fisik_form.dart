import 'package:flutter/material.dart';
import '../bloc/catatan_aktivitas_fisik_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/catatan_aktivitas_fisik.dart';
import 'catatan_aktivitas_fisik_page.dart';

// ignore: must_be_immutable
class CatatanAktivitasFisikForm extends StatefulWidget {
  Catatan_aktivitas_fisik? catatanAktivitasFisik;

  CatatanAktivitasFisikForm({Key? key, this.catatanAktivitasFisik})
      : super(key: key);

  @override
  _CatatanAktivitasFisikFormState createState() =>
      _CatatanAktivitasFisikFormState();
}

class _CatatanAktivitasFisikFormState extends State<CatatanAktivitasFisikForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH CATATAN AKTIVITAS FISIK";
  String tombolSubmit = "SIMPAN";

  final _activityNameController = TextEditingController();
  final _durationController = TextEditingController();
  final _intensityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.catatanAktivitasFisik != null) {
      setState(() {
        judul = "UBAH CATATAN AKTIVITAS FISIK";
        tombolSubmit = "UBAH";
        _activityNameController.text =
            widget.catatanAktivitasFisik!.activityName!;
        _durationController.text =
            widget.catatanAktivitasFisik!.duration.toString();
        _intensityController.text = widget.catatanAktivitasFisik!.intensity!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul,
            style: const TextStyle(
              fontFamily: 'Helvetica',
            )),
        backgroundColor: Colors.yellow, // Warna background AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _activityNameTextField(),
                _durationTextField(),
                _intensityTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.yellow[100], // Latar belakang kuning terang
    );
  }

  // Membuat Textbox Nama Aktivitas
  Widget _activityNameTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Aktivitas"),
      controller: _activityNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Aktivitas harus diisi";
        }
        return null;
      },
      style: const TextStyle(
          fontFamily: 'Helvetica'), // Menambahkan font Helvetica
    );
  }

  // Membuat Textbox Durasi
  Widget _durationTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Durasi (menit)"),
      keyboardType: TextInputType.number,
      controller: _durationController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Durasi harus diisi";
        }
        return null;
      },
      style: const TextStyle(
          fontFamily: 'Helvetica'), // Menambahkan font Helvetica
    );
  }

  // Membuat Textbox Intensitas
  Widget _intensityTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Intensitas"),
      controller: _intensityController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Intensitas harus diisi";
        }
        return null;
      },
      style: const TextStyle(
          fontFamily: 'Helvetica'), // Menambahkan font Helvetica
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow, // Warna tombol kuning
        textStyle: const TextStyle(
          fontFamily: 'Helvetica',
          color: Colors.black,
        ),
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.catatanAktivitasFisik != null) {
              // kondisi update catatan aktivitas fisik
              ubah();
            } else {
              // kondisi tambah catatan aktivitas fisik
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });

    Catatan_aktivitas_fisik createCatatan = Catatan_aktivitas_fisik();
    createCatatan.activityName = _activityNameController.text;
    createCatatan.duration = int.parse(_durationController.text);
    createCatatan.intensity = _intensityController.text;

    CatatanAktivitasFisikBloc.addCatatanAktivitas(catatan: createCatatan).then(
        (value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              const CatatanAktivitasFisikPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });

    Catatan_aktivitas_fisik updateCatatan =
        Catatan_aktivitas_fisik(id: widget.catatanAktivitasFisik!.id!);
    updateCatatan.activityName = _activityNameController.text;
    updateCatatan.duration = int.parse(_durationController.text);
    updateCatatan.intensity = _intensityController.text;

    CatatanAktivitasFisikBloc.updateCatatanAktivitas(catatan: updateCatatan)
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              const CatatanAktivitasFisikPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }
}
