import 'package:flutter/material.dart';
import '../bloc/catatan_aktivitas_fisik_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/catatan_aktivitas_fisik.dart';
import '/ui/catatan_aktivitas_fisik_form.dart';
import 'catatan_aktivitas_fisik_page.dart';

// ignore: must_be_immutable
class CatatanAktivitasFisikDetail extends StatefulWidget {
  Catatan_aktivitas_fisik? catatan;

  CatatanAktivitasFisikDetail({Key? key, this.catatan}) : super(key: key);

  @override
  _CatatanAktivitasFisikDetailState createState() =>
      _CatatanAktivitasFisikDetailState();
}

class _CatatanAktivitasFisikDetailState
    extends State<CatatanAktivitasFisikDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan Aktivitas Fisik'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                'Nama Aktivitas: ${widget.catatan?.activityName ?? 'Tidak ada data'}'),
            Text(
                'Durasi: ${widget.catatan?.duration?.toString() ?? 'Tidak ada data'} menit'),
            Text(
                'Intensitas: ${widget.catatan?.intensity ?? 'Tidak ada data'}'),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatatanAktivitasFisikForm(
                  catatanAktivitasFisik: widget.catatan!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            CatatanAktivitasFisikBloc.deleteCatatanAktivitas(
                    id: widget.catatan!.id!)
                .then(
              (value) => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CatatanAktivitasFisikPage(),
                ))
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
