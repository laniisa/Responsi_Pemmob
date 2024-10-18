class Catatan_aktivitas_fisik {
  int? id;
  String? activityName;
  int? duration;
  String? intensity;
  Catatan_aktivitas_fisik(
      {this.id, this.activityName, this.duration, this.intensity});
  factory Catatan_aktivitas_fisik.fromJson(Map<String, dynamic> obj) {
    return Catatan_aktivitas_fisik(
        id: obj['id'],
        activityName: obj['activity_name'],
        duration: obj['duration'],
        intensity: obj['intensity']);
  }
}
