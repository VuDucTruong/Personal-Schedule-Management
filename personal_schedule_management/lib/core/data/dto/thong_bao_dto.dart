import 'package:cloud_firestore/cloud_firestore.dart';

class ThongBaoDTO {
  String maTB;
  String maCV;
  int loaiTB;
  Timestamp thoiGian;

  ThongBaoDTO(this.maTB, this.maCV, this.loaiTB, this.thoiGian);

  toJson() {
    return {'maCV': maCV, 'loaiTB': loaiTB, 'thoiGian': thoiGian};
  }
}
