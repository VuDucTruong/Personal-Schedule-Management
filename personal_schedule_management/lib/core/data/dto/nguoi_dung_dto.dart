import 'package:personal_schedule_management/core/data/dto/thu_moi_dto.dart';
import 'package:personal_schedule_management/core/domain/entity/nguoi_dung_entity.dart';

import 'cong_viec_dto.dart';

class NguoiDungDTO {
  String maND;
  String hoTen;
  String email;

  NguoiDungDTO(this.maND, this.hoTen, this.email);
  Map<String, dynamic> toJson() {
    return {
      'hoTen': hoTen,
      'email': email,
    };
  }

  factory NguoiDungDTO.fromJson(Map<String, dynamic> data, String userId) {
    return NguoiDungDTO(userId, data['hoTen'], data['email']);
  }
  NguoiDung toNguoiDung() {
    return NguoiDung(maND, hoTen, email);
  }
}
