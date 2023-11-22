import 'package:personal_schedule_management/core/domain/entity/chu_ky_entity.dart';

class ChuKyDTO {
  String maCK;
  String tenCK;
  String? thoiDiemLap;

  ChuKyDTO(this.maCK, this.tenCK, this.thoiDiemLap);
  toJson() {
    return {
      'maCK': maCK,
      'tenCK': tenCK,
      'thoiDiemLap': thoiDiemLap,
    };
  }

  factory ChuKyDTO.fromJson(Map<String, dynamic> json, String id) {
    return ChuKyDTO(id, json['tenCK'], json['thoiDiemLap']);
  }
  toChuKy() {
    return ChuKy(maCK, tenCK, thoiDiemLap);
  }

  @override
  String toString() {
    return 'ChuKyDTO{maCK: $maCK, tenCK: $tenCK, thoiDiemLap: $thoiDiemLap}';
  }
}
