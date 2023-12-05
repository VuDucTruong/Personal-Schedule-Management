import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';

abstract class WorkRespository {
  Future<String?> insertWorkToRemote(CongViec congViec);
  Future<List<CongViec>> getAllCongViecByUserId(String userId);
  Future<void> deleteWorkById(String maCV);
  Future<CongViec?> getCongViecById(String maCV);
  Future<String?> updateWorkToRemote(CongViec congViec);
  Future<void> updateTinhTrangWork(String maCV, int trangThai);
  Future<void> addException(String maCV, DateTime exception);
}
