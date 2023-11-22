import 'package:personal_schedule_management/core/domain/entity/chu_ky_entity.dart';

abstract class RecurrenceRespository {
  Future<String?> insertRecurrenceWorkToRemote(ChuKy chuKy);
  Future<ChuKy?> getChuKyById(String maCK);
}
