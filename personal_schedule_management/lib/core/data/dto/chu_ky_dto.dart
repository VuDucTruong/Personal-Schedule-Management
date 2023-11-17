import 'package:cloud_firestore/cloud_firestore.dart';

class ChuKyDTO {
  String maCK;
  String tenCK;
  String thoiDiemLap;
  Timestamp thoiDiemKetThuc;

  ChuKyDTO(this.maCK, this.tenCK, this.thoiDiemLap, this.thoiDiemKetThuc);
  toJson() {
    return {
      'tenCK': tenCK,
      'thoiDiemLap': thoiDiemLap,
      'thoiDiemKetThuc': thoiDiemKetThuc
    };
  }
}
