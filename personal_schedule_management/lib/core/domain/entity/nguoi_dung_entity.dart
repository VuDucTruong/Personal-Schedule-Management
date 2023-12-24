import 'package:personal_schedule_management/core/data/dto/nguoi_dung_dto.dart';
import 'package:personal_schedule_management/core/domain/entity/thu_moi_entity.dart';

import 'cong_viec_entity.dart';

class NguoiDung {
  String maND;
  String hoTen;
  String email;

  NguoiDung(this.maND, this.hoTen, this.email);
  NguoiDungDTO toNguoiDungDTO() {
    return NguoiDungDTO(maND, hoTen, email);
  }
}
