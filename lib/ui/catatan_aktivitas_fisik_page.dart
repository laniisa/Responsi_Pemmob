import 'package:flutter/material.dart';
import '/model/catatan_aktivitas_fisik.dart'; // Pastikan import model dengan benar
import '/ui/catatan_aktivitas_fisik_detail.dart';
import '/ui/catatan_aktivitas_fisik_form.dart';
import '../bloc/logout_bloc.dart'; // Pastikan bloc sudah ada
import '../bloc/catatan_aktivitas_fisik_bloc.dart'; // Pastikan bloc sudah ada
import '/ui/login_page.dart'; // Halaman login

class CatatanAktivitasFisikPage extends StatefulWidget {
  const CatatanAktivitasFisikPage({Key? key}) : super(key: key);

  @override
  _CatatanAktivitasFisikPageState createState() =>
      _CatatanAktivitasFisikPageState();
}

class _CatatanAktivitasFisikPageState extends State<CatatanAktivitasFisikPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Catatan Aktivitas Fisik',
            style: TextStyle(fontFamily: 'Helvetica')),
        backgroundColor: Colors.yellow, // Warna background AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CatatanAktivitasFisikForm()), // Mengarahkan ke form tambah aktivitas fisik
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout',
                  style: TextStyle(fontFamily: 'Helvetica')),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CatatanAktivitasLoginPage()), // Mengarahkan ke halaman login
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.yellow[100], // Warna latar belakang terang
        child: FutureBuilder<List<Catatan_aktivitas_fisik>>(
          future: CatatanAktivitasFisikBloc
              .getCatatanAktivitas(), // Memanggil bloc untuk mengambil data
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text("Error loading data"));
            }
            return snapshot.hasData
                ? ListCatatanAktivitasFisik(list: snapshot.data)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListCatatanAktivitasFisik extends StatelessWidget {
  final List<Catatan_aktivitas_fisik>? list;

  const ListCatatanAktivitasFisik({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          list == null ? 0 : list!.length, // Jika list kosong, maka tampilkan 0
      itemBuilder: (context, i) {
        return ItemCatatanAktivitasFisik(
            catatanAktivitasFisik:
                list![i]); // Membuat widget untuk setiap item
      },
    );
  }
}

class ItemCatatanAktivitasFisik extends StatelessWidget {
  final Catatan_aktivitas_fisik catatanAktivitasFisik;

  const ItemCatatanAktivitasFisik(
      {Key? key, required this.catatanAktivitasFisik})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CatatanAktivitasFisikDetail(
              catatan:
                  catatanAktivitasFisik, // Mengirim data catatan aktivitas fisik ke halaman detail
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(
            catatanAktivitasFisik.activityName ?? 'Tidak ada aktivitas',
            style: const TextStyle(fontFamily: 'Helvetica'), // Mengatur font
          ),
          subtitle: Text(
              '${catatanAktivitasFisik.duration?.toString() ?? '0'} menit',
              style:
                  const TextStyle(fontFamily: 'Helvetica')), // Durasi aktivitas
          trailing: Text(
              catatanAktivitasFisik.intensity ?? 'Tidak ada intensitas',
              style: const TextStyle(
                  fontFamily: 'Helvetica')), // Intensitas aktivitas
        ),
      ),
    );
  }
}
