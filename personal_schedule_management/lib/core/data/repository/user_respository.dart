import 'package:personal_schedule_management/core/domain/entity/nguoi_dung_entity.dart';

abstract class UserRespository {
  Future<void> addUser(NguoiDung nguoiDung);
  Future<void> getUserEmailById(String maND);
}
