import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_ht_dto.dart';

class CongViecHT {
  late DateTime ngayBatDau;
  late DateTime ngayKetThuc;
  late DateTime ngayHoanThanh;

  CongViecHT(this.ngayBatDau, this.ngayKetThuc, this.ngayHoanThanh);

  CongViecHT.zero() {
    this.ngayBatDau = this.ngayKetThuc = this.ngayHoanThanh = DateTime.now();
  }
  CongViecHTDTO toCongViecHTDTO() {
    return CongViecHTDTO(Timestamp.fromDate(ngayBatDau),
        Timestamp.fromDate(ngayKetThuc), Timestamp.fromDate(ngayHoanThanh));
  }

  Map<String, dynamic> toJson() {
    return {
      'ngayBatDau': ngayBatDau,
      'ngayKetThuc': ngayKetThuc,
      'ngayHoanThanh': ngayHoanThanh
    };
  }
}
