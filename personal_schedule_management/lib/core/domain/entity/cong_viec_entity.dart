import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_dto.dart';
import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

import 'cong_viec_ht_entity.dart';

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
  List<CongViecHT> congViecHTList;
  List<ThongBao> thongBaoList;

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
      this.ngayNgoaiLe,
      this.congViecHTList,
      this.thongBaoList);

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
        this.ngayNgoaiLe.map((e) => Timestamp.fromDate(e)).toList(),
        congViecHTList.map((e) => e.toCongViecHTDTO().toJson()).toList(),
        thongBaoList.map((e) => e.toThongBaoDTO().toJson()).toList());
  }

  @override
  String toString() {
    return 'CongViec{maCV: $maCV, maND: $maND, tieuDe: $tieuDe, noiDung: $noiDung, loaiCongViec: $loaiCongViec, ngayBatDau: $ngayBatDau, ngayKetThuc: $ngayKetThuc, isCaNgay: $isCaNgay, doUuTien: $doUuTien, mauSac: $mauSac, diaDiem: $diaDiem, url: $url, isKhachMoi: $isKhachMoi, tenCK: $tenCK, thoiDiemLap: $thoiDiemLap, isBaoThuc: $isBaoThuc, ngayNgoaiLe: $ngayNgoaiLe, congViecHTList: $congViecHTList, thongBaoList: $thongBaoList}';
  }
}
