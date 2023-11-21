import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

abstract class NotificationRespository {
  Future<String?> insertNotificationToRemote(ThongBao thongBao);
}
