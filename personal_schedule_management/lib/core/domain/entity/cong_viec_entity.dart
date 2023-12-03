import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_dto.dart';

class CongViec {
  String maCV;
  String maND;
  String tieuDe;
  String noiDung;
  String loaiCongViec;
  DateTime ngayBatDau, ngayKetThuc;
  bool isCaNgay;
  int doUuTien;
  Color mauSac;
  String diaDiem;
  String url;
  bool isKhachMoi;
  String tenCK;
  String thoiDiemLap;
  bool isBaoThuc;
  List<DateTime> ngayNgoaiLe;

  CongViec(
      this.maCV,
      this.maND,
      this.tieuDe,
      this.noiDung,
      this.loaiCongViec,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.isCaNgay,
      this.doUuTien,
      this.mauSac,
      this.diaDiem,
      this.url,
      this.isKhachMoi,
      this.tenCK,
      this.thoiDiemLap,
      this.isBaoThuc,
      this.ngayNgoaiLe);

  toCongViecDTO() {
    return CongViecDTO(
        maCV,
        maND,
        tieuDe,
        noiDung,
        loaiCongViec,
        Timestamp.fromDate(ngayBatDau),
        Timestamp.fromDate(ngayKetThuc),
        isCaNgay,
        doUuTien,
        mauSac.value.toString(),
        diaDiem,
        url,
        isKhachMoi,
        tenCK,
        thoiDiemLap,
        this.isBaoThuc,
        this.ngayNgoaiLe.map((e) => Timestamp.fromDate(e)).toList());
  }
}
