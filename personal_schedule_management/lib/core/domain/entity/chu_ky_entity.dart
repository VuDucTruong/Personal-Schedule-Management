import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/chu_ky_dto.dart';

class ChuKy {
  String maCK;
  String tenCK;
  String thoiDiemLap;
  DateTime ngayKetThuc;

  ChuKy(this.maCK, this.tenCK, this.thoiDiemLap, this.ngayKetThuc);

  ChuKyDTO toChuKyDTO() {
    return ChuKyDTO(maCK, tenCK, thoiDiemLap, Timestamp.fromDate(ngayKetThuc));
  }
}
