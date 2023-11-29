import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_ht_dto.dart';

class CongViecHT {
  late String maCVHT;
  late String maCV;
  late DateTime ngayBatDau;
  late DateTime ngayKetThuc;
  late DateTime ngayHoanThanh;

  CongViecHT(this.maCVHT, this.maCV, this.ngayBatDau, this.ngayKetThuc,
      this.ngayHoanThanh);

  CongViecHT.zero() {
    this.maCV = this.maCVHT = '';
    this.ngayBatDau = this.ngayKetThuc = this.ngayHoanThanh = DateTime.now();
  }
  toCongViecHTDTO() {
    return CongViecHTDTO(this.maCVHT, maCV, Timestamp.fromDate(ngayBatDau),
        Timestamp.fromDate(ngayKetThuc), Timestamp.fromDate(ngayHoanThanh));
  }
}
