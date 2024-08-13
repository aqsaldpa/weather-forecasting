import 'dart:convert';

class Wilayah {
  final String id;
  final String propinsi;
  final String kota;
  final String kecamatan;
  final String lat;
  final String lon;
  Wilayah({
    required this.id,
    required this.propinsi,
    required this.kota,
    required this.kecamatan,
    required this.lat,
    required this.lon,
  });

  Wilayah copyWith({
    String? id,
    String? propinsi,
    String? kota,
    String? kecamatan,
    String? lat,
    String? lon,
  }) {
    return Wilayah(
      id: id ?? this.id,
      propinsi: propinsi ?? this.propinsi,
      kota: kota ?? this.kota,
      kecamatan: kecamatan ?? this.kecamatan,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'propinsi': propinsi,
      'kota': kota,
      'kecamatan': kecamatan,
      'lat': lat,
      'lon': lon,
    };
  }

  factory Wilayah.fromMap(Map<String, dynamic> map) {
    return Wilayah(
      id: map['id'] as String,
      propinsi: map['propinsi'] as String,
      kota: map['kota'] as String,
      kecamatan: map['kecamatan'] as String,
      lat: map['lat'] as String,
      lon: map['lon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wilayah.fromJson(String source) =>
      Wilayah.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Wilayah(id: $id, propinsi: $propinsi, kota: $kota, kecamatan: $kecamatan, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(covariant Wilayah other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.propinsi == propinsi &&
        other.kota == kota &&
        other.kecamatan == kecamatan &&
        other.lat == lat &&
        other.lon == lon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        propinsi.hashCode ^
        kota.hashCode ^
        kecamatan.hashCode ^
        lat.hashCode ^
        lon.hashCode;
  }
}
