import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_ht_dto.dart';

class CongViecHT {
  String maCVHT;
  String maCV;
  DateTime ngayBatDau;
  DateTime ngayKetThuc;
  DateTime ngayHoanThanh;

  CongViecHT(this.maCVHT, this.maCV, this.ngayBatDau, this.ngayKetThuc,
      this.ngayHoanThanh);

  toCongViecHTDTO() {
    return CongViecHTDTO(this.maCVHT, maCV, Timestamp.fromDate(ngayBatDau),
        Timestamp.fromDate(ngayKetThuc), Timestamp.fromDate(ngayHoanThanh));
  }
}
