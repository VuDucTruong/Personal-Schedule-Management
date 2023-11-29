import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';

abstract class CompletedWorkRespository {
  Future<String?> insertCompletedWork(CongViecHT congViecHT);
  Future<void> deleteCompletedWork(String maCV, DateTime startDay);
  Future<CongViecHT> getCompletedWork(String maCV, DateTime startDay);
  Future<List<CongViecHT>> getAllCompletedWork();
}
