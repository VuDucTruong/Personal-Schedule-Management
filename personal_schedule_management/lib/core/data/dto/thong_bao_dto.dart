import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

class ThongBaoDTO {
  String tenTB;
  String thoiGian;

  ThongBaoDTO(this.tenTB, this.thoiGian);

  Map<String, dynamic> toJson() {
    return {'tenTB': tenTB, 'thoiGian': thoiGian};
  }

  factory ThongBaoDTO.fromJson(Map<String, dynamic> json) {
    return ThongBaoDTO(json['tenTB'], json['thoiGian']);
  }

  ThongBao toThongBao() {
    return ThongBao(tenTB, parseDuration(thoiGian));
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
