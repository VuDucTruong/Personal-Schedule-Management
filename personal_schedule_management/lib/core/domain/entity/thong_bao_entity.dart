import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/thong_bao_dto.dart';

class ThongBao {
  String maTB;
  String maCV;
  String tenTB;
  DateTime thoiGian;

  ThongBao(this.maTB, this.maCV, this.tenTB, this.thoiGian);

  ThongBaoDTO toThongBaoDTO() {
    return ThongBaoDTO(maTB, maCV, this.tenTB, Timestamp.fromDate(thoiGian));
  }
}
