import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/dto/thong_bao_dto.dart';
import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

import '../../data/repository/notification_respository.dart';

class NotificationRespositoryImpl extends NotificationRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<String?> insertNotificationToRemote(ThongBao thongBao) async {
    // TODO: implement insertNotificationListToRemote
    ThongBaoDTO thongBaoDTO = thongBao.toThongBaoDTO();
    DocumentReference docRef =
        await _storage.collection(THONGBAO).add(thongBaoDTO.toJson());
    if (docRef.id.isNotEmpty) return docRef.id;
    return null;
  }
}
