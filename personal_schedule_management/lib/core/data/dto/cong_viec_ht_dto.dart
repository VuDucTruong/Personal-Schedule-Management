import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';

class CongViecHTDTO {
  String maCVHT;
  String maCV;
  Timestamp ngayBatDau;
  Timestamp ngayKetThuc;
  Timestamp ngayHoanThanh;

  CongViecHTDTO(this.maCVHT, this.maCV, this.ngayBatDau, this.ngayKetThuc,
      this.ngayHoanThanh);

  toJson() {
    return {
      'maCVHT': maCVHT,
      'maCV': maCV,
      'ngayBatDau': ngayBatDau,
      'ngayKetThuc': ngayKetThuc,
      'ngayHoanThanh': ngayHoanThanh
    };
  }

  factory CongViecHTDTO.fromJson(Map<String, dynamic> json, String id) {
    return CongViecHTDTO(id, json['maCV'], json['ngayBatDau'],
        json['ngayKetThuc'], json['ngayHoanThanh']);
  }

  toCongViecHT() {
    return CongViecHT(maCVHT, maCV, ngayBatDau.toDate(), ngayKetThuc.toDate(),
        ngayHoanThanh.toDate());
  }
}
