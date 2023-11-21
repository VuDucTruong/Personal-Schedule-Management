import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';

abstract class WorkRespository {
  Future<String?> insertWorkToRemote(CongViec congViec);
}
