import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';

import '../../domain/entity/thong_bao_entity.dart';

abstract class WorkRespository {
  Future<String?> insertWorkToRemote(CongViec congViec);
  Future<List<CongViec>> getAllCongViecByUserId(String userId);
  Future<void> deleteWorkById(String maCV);
  Future<CongViec?> getCongViecById(String maCV);
  Future<String?> updateWorkToRemote(CongViec congViec);
  Future<void> updateTinhTrangWork(String maCV, int trangThai);
  Future<void> addException(String maCV, DateTime exception);
  Future<List<CongViec>> findWorkByTitle(String title);
  Future<void> addCongViecHT(CongViecHT congViecHT, String maCV);
  Future<void> removeCongViecHT(DateTime ngayBatDau, String maCV);
  Future<void> addThongBao(ThongBao thongBao, String maCV);
  Future<void> removeThongBao(ThongBao thongBao, String maCV);
  Future<CongViecHT?> getCongViecHTByWorkId(String maCV, DateTime startTime);
  Future<List<ThongBao>> getThongBaoListByWorkId(String maCV);
}
