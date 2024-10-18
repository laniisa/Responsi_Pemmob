import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/catatan_aktivitas_fisik.dart'; // Ganti dengan path yang sesuai untuk model Anda

class CatatanAktivitasFisikBloc {
  static Future<List<Catatan_aktivitas_fisik>> getCatatanAktivitas() async {
    String apiUrl = ApiUrl
        .listCatatanAktivitasFisik; // Endpoint untuk mendapatkan semua catatan aktivitas
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listCatatanAktivitas =
        (jsonObj as Map<String, dynamic>)['data'];
    List<Catatan_aktivitas_fisik> catatanAktivitas = [];

    for (int i = 0; i < listCatatanAktivitas.length; i++) {
      catatanAktivitas
          .add(Catatan_aktivitas_fisik.fromJson(listCatatanAktivitas[i]));
    }

    return catatanAktivitas;
  }

  static Future addCatatanAktivitas({Catatan_aktivitas_fisik? catatan}) async {
    String apiUrl = ApiUrl
        .createCatatanAktivitasFisik; // Endpoint untuk membuat catatan aktivitas

    var body = {
      "activity_name": catatan!.activityName,
      "duration": catatan.duration,
      "intensity": catatan.intensity
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateCatatanAktivitas(
      {required Catatan_aktivitas_fisik catatan}) async {
    String apiUrl = ApiUrl.updateCatatanAktivitas(
        catatan.id!); // Endpoint untuk memperbarui catatan aktivitas

    var body = {
      "activity_name": catatan.activityName,
      "duration": catatan.duration,
      "intensity": catatan.intensity
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteCatatanAktivitas({int? id}) async {
    String apiUrl = ApiUrl.deleteCatatanAktivitas(
        id!); // Endpoint untuk menghapus catatan aktivitas
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
