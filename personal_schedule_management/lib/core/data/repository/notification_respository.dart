import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

abstract class NotificationRespository {
  Future<String?> insertNotificationToWork(ThongBao thongBao, String maCV);
  Future<List<ThongBao>> getNotificationByWorkId(String maCV);
  Future<void> deleteALlNotificationByWorkId(String maCV);
}
