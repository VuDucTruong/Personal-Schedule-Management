import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

class ThongBaoDTO {
  String maTB;
  String maCV;
  String tenTB;
  Timestamp thoiGian;

  ThongBaoDTO(this.maTB, this.maCV, this.tenTB, this.thoiGian);

  toJson() {
    return {'maTB': maTB, 'maCV': maCV, 'tenTB': tenTB, 'thoiGian': thoiGian};
  }

  factory ThongBaoDTO.fromJson(Map<String, dynamic> json) {
    return ThongBaoDTO(
        json['maTB'], json['maCV'], json['tenTB'], json['thoiGian']);
  }

  toThongBao() {
    return ThongBao(maTB, maCV, tenTB, thoiGian.toDate());
  }
}
