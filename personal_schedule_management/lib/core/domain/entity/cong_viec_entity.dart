import 'dart:ui';

class CongViec {
  String maCV;
  String maND;
  String maLCV;
  String tieuDe;
  String noiDung;
  DateTime ngayBatDau, ngayKetThuc;
  DateTime thoiGianBatDau, thoiGianKetThuc;
  bool isCaNgay;
  int trangThai;
  int doUuTien;
  Color mauSac;
  String diaDiem;
  bool isKhachMoi;

  CongViec(
      this.maCV,
      this.maND,
      this.maLCV,
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
