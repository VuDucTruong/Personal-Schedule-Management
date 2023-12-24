import 'package:personal_schedule_management/core/domain/entity/thu_moi_entity.dart';

abstract class InvitationRespository {
  Future<List<ThuMoi>> getAllInvitaions();
  Future<void> deleleInvitationById(String maTM);
  Future<void> addInvitation(ThuMoi thuMoi);
  Future<void> updateInvitationStatus(ThuMoi thuMoi);
}
