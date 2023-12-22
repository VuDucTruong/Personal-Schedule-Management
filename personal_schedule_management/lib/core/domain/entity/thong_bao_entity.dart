import 'package:personal_schedule_management/core/data/dto/thong_bao_dto.dart';

class ThongBao {
  String tenTB;
  Duration thoiGian;

  ThongBao(this.tenTB, this.thoiGian);

  ThongBaoDTO toThongBaoDTO() {
    return ThongBaoDTO(this.tenTB, thoiGian.toString());
  }
}
