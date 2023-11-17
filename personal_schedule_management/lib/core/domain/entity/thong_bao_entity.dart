import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/thong_bao_dto.dart';

class ThongBao {
  String maTB;
  String maCV;
  int loaiTB;
  DateTime thoiGian;

  ThongBao(this.maTB, this.maCV, this.loaiTB, this.thoiGian);

  ThongBaoDTO toThongBaoDTO() {
    return ThongBaoDTO(maTB, maCV, loaiTB, Timestamp.fromDate(thoiGian));
  }
}
