import 'package:cloud_firestore/cloud_firestore.dart';

class CongViecDTO {
  String maCV;
  String maND;
  String maLCV;
  String maCK;
  String tieuDe;
  String noiDung;
  Timestamp ngayBatDau;
  Timestamp ngayKetThuc;
  Timestamp thoiGianBatDau;
  Timestamp thoiGianKetThuc;
  bool isCaNgay;
  int trangThai;
  int doUuTien;
  String mauSac;
  String diaDiem;
  bool isKhachMoi;

  CongViecDTO(
      this.maCV,
      this.maND,
      this.maLCV,
      this.maCK,
      this.tieuDe,
      this.noiDung,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.thoiGianBatDau,
      this.thoiGianKetThuc,
      this.isCaNgay,
      this.trangThai,
      this.doUuTien,
      this.mauSac,
      this.diaDiem,
      this.isKhachMoi);
}
