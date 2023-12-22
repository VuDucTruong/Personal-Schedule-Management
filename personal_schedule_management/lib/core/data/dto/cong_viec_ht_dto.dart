import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';

class CongViecHTDTO {
  Timestamp ngayBatDau;
  Timestamp ngayKetThuc;
  Timestamp ngayHoanThanh;

  CongViecHTDTO(this.ngayBatDau, this.ngayKetThuc, this.ngayHoanThanh);

  Map<String, dynamic> toJson() {
    return {
      'ngayBatDau': ngayBatDau,
      'ngayKetThuc': ngayKetThuc,
      'ngayHoanThanh': ngayHoanThanh
    };
  }

  factory CongViecHTDTO.fromJson(Map<String, dynamic> json) {
    return CongViecHTDTO(
        json['ngayBatDau'], json['ngayKetThuc'], json['ngayHoanThanh']);
  }

  CongViecHT toCongViecHT() {
    return CongViecHT(
        ngayBatDau.toDate(), ngayKetThuc.toDate(), ngayHoanThanh.toDate());
  }
}
