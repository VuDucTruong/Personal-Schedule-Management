import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';

class CongViecDTO {
  String? maCV;
  String? maND;
  String? tieuDe;
  String? noiDung;
  String? loaiCongViec;
  Timestamp ngayBatDau;
  Timestamp ngayKetThuc;
  bool isCaNgay;
  int doUuTien;
  String? mauSac;
  String? diaDiem;
  String? url;
  bool isKhachMoi;
  String? tenCK;
  String? thoiDiemLap;
  bool isBaoThuc;
  List<Timestamp> ngayNgoaiLe;

  CongViecDTO(
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

  toJson() {
    return {
      "maCV": maCV,
      "maND": maND,
      "tieuDe": tieuDe,
      "noiDung": noiDung,
      "loaiCongViec": loaiCongViec,
      "ngayBatDau": ngayBatDau,
      "ngayKetThuc": ngayKetThuc,
      "isCaNgay": isCaNgay,
      "doUuTien": doUuTien,
      "mauSac": mauSac,
      "diaDiem": diaDiem,
      "url": url,
      "isKhachMoi": isKhachMoi,
      "tenCK": tenCK,
      "thoiDiemLap": thoiDiemLap,
      "isBaoThuc": isBaoThuc,
      "ngayNgoaiLe": ngayNgoaiLe,
    };
  }

  factory CongViecDTO.fromJson(Map<String, dynamic> json, String id) {
    return CongViecDTO(
        id,
        json['maND'],
        json['tieuDe'],
        json['noiDung'],
        json["loaiCongViec"],
        json['ngayBatDau'],
        json['ngayKetThuc'],
        json['isCaNgay'],
        json['doUuTien'],
        json['mauSac'],
        json['diaDiem'],
        json['url'],
        json['isKhachMoi'],
        json['tenCK'],
        json['thoiDiemLap'],
        json['isBaoThuc'],
        List.from(json['ngayNgoaiLe']));
  }

  toCongViec() {
    return CongViec(
        maCV ?? '',
        maND ?? '',
        tieuDe ?? '',
        noiDung ?? '',
        loaiCongViec ?? '',
        ngayBatDau.toDate(),
        ngayKetThuc.toDate(),
        isCaNgay,
        doUuTien,
        Color(int.parse(mauSac!)),
        diaDiem ?? '',
        url ?? '',
        isKhachMoi,
        tenCK ?? '',
        thoiDiemLap ?? '',
        isBaoThuc,
        ngayNgoaiLe.map((e) => e.toDate()).toList());
  }
}
