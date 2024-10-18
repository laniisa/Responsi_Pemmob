class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listCatatanAktivitasFisik = baseUrl +
      '/kesehatan/catatan_aktivitas_fisik'; // Endpoint untuk mendapatkan semua catatan aktivitas
  static const String createCatatanAktivitasFisik = baseUrl +
      '/kesehatan/catatan_aktivitas_fisik'; // Endpoint untuk membuat catatan aktivitas

  static String updateCatatanAktivitas(int id) {
    return baseUrl +
        '/kesehatan/catatan_aktivitas_fisik/' +
        id.toString(); // Endpoint untuk memperbarui catatan aktivitas berdasarkan ID
  }

  static String showCatatanAktivitas(int id) {
    return baseUrl +
        '/kesehatan/catatan_aktivitas_fisik/' +
        id.toString(); // Endpoint untuk mendapatkan detail catatan aktivitas berdasarkan ID
  }

  static String deleteCatatanAktivitas(int id) {
    return baseUrl +
        '/kesehatan/catatan_aktivitas_fisik/' +
        id.toString(); // Endpoint untuk menghapus catatan aktivitas berdasarkan ID
  }
}
