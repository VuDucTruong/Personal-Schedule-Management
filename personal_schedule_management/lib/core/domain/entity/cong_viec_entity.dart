import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_dto.dart';

class CongViec {
  String maCV;
  String maND;
  String maCK;
  String tieuDe;
  String noiDung;
  String loaiCongViec;
  DateTime ngayBatDau, ngayKetThuc;
  bool isCaNgay;
  int trangThai;
  int doUuTien;
  Color mauSac;
  String diaDiem;
  String url;
  bool isKhachMoi;

  CongViec(
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

  toCongViecDTO() {
    return CongViecDTO(
        maCV,
        maND,
        maCK,
        tieuDe,
        noiDung,
        loaiCongViec,
        Timestamp.fromDate(ngayBatDau),
        Timestamp.fromDate(ngayKetThuc),
        isCaNgay,
        trangThai,
        doUuTien,
        mauSac.value.toString(),
        diaDiem,
        url,
        isKhachMoi);
  }
}
