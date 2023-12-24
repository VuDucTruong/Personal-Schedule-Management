import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/invitation_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/user_respository_impl.dart';

import '../../core/domain/entity/thu_moi_entity.dart';

class InvitationController {
  InvitationRespositoryImpl invitationRespositoryImpl =
      GetIt.instance<InvitationRespositoryImpl>();
  UserRespositoryImpl userRespositoryImpl =
      GetIt.instance<UserRespositoryImpl>();
  List<ThuMoi> thuMoiList = [];
  Future<void> getInvitationList() async {
    thuMoiList = await invitationRespositoryImpl.getAllInvitaions();
  }

  Future<void> deleteInvitation(String maTM) async {
    await invitationRespositoryImpl.deleleInvitationById(maTM);
  }

  Future<void> updateInvitationStatus(ThuMoi thuMoi) async {
    await invitationRespositoryImpl.updateInvitationStatus(thuMoi);
  }
}
