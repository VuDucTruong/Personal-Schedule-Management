import 'package:cloud_firestore/cloud_firestore.dart';

class CongViecDTO {
  String maCV;
  String maND;
  String maCK;
  String tieuDe;
  String noiDung;
  String loaiCongViec;
  Timestamp ngayBatDau;
  Timestamp ngayKetThuc;
  bool isCaNgay;
  int trangThai;
  int doUuTien;
  String mauSac;
  String diaDiem;
  String url;
  bool isKhachMoi;

  CongViecDTO(
      this.maCV,
      this.maND,
      this.maCK,
      this.tieuDe,
      this.noiDung,
      this.loaiCongViec,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.isCaNgay,
      this.trangThai,
      this.doUuTien,
      this.mauSac,
      this.diaDiem,
      this.url,
      this.isKhachMoi);

  toJson() {
    return {
      "maND": maND,
      "maCK": maCK,
      "tieuDe": tieuDe,
      "noiDung": noiDung,
      "loaiCongViec": loaiCongViec,
      "ngayBatDau": ngayBatDau,
      "ngayKetThuc": ngayKetThuc,
      "isCaNgay": isCaNgay,
      "trangThai": trangThai,
      "doUuTien": doUuTien,
      "mauSac": mauSac,
      "diaDiem": diaDiem,
      "url": url,
      "isKhachMoi": isKhachMoi
    };
  }

  factory CongViecDTO.fromJson(Map<String, dynamic> json) {
    return CongViecDTO(
        json['maCV'],
        json['maND'],
        json['maCK'],
        json['tieuDe'],
        json['noiDung'],
        json["loaiCongViec"],
        json['ngayBatDau'],
        json['ngayKetThuc'],
        json['isCaNgay'],
        json['trangThai'],
        json['doUuTien'],
        json['mauSac'],
        json['diaDiem'],
        json['url'],
        json['isKhachMoi']);
  }
}
