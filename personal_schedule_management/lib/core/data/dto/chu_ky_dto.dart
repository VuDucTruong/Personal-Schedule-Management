import 'package:cloud_firestore/cloud_firestore.dart';

class ChuKyDTO {
  String maCK;
  String tenCK;
  Timestamp ThoiDiemLap;
  Timestamp ThoiDiemKetThuc;

  ChuKyDTO(this.maCK, this.tenCK, this.ThoiDiemLap, this.ThoiDiemKetThuc);
}
