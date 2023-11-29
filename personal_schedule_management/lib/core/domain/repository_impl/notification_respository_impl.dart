import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/dto/thong_bao_dto.dart';
import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

import '../../data/repository/notification_respository.dart';

class NotificationRespositoryImpl extends NotificationRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<String?> insertNotificationToWork(
      ThongBao thongBao, String maCV) async {
    // TODO: implement insertNotificationListToRemote
    ThongBaoDTO thongBaoDTO = thongBao.toThongBaoDTO();
    DocumentReference docRef = await _storage
        .collection(CONGVIEC)
        .doc(maCV)
        .collection(THONGBAO)
        .add(thongBaoDTO.toJson());
    if (docRef.id.isNotEmpty) {
      thongBaoDTO.maTB = docRef.id;
      await docRef.set(thongBaoDTO.toJson());
      return docRef.id;
    }
    return null;
  }

  @override
  Future<List<ThongBao>> getNotificationByWorkId(String maCV) async {
    var data = await _storage
        .collection(CONGVIEC)
        .doc(maCV)
        .collection(THONGBAO)
        .get();
    List<ThongBao> thongBaoList = [];
    data.docs.forEach((element) {
      ThongBaoDTO thongBaoDTO = ThongBaoDTO.fromJson(element.data());
      thongBaoList.add(thongBaoDTO.toThongBao());
    });
    return thongBaoList;
  }

  @override
  Future<void> deleteALlNotificationByWorkId(String maCV) async {
    if (maCV.isNotEmpty) {
      var docRef = await _storage
          .collection(CONGVIEC)
          .doc(maCV)
          .collection(THONGBAO)
          .get();
      docRef.docs.forEach((element) {
        element.reference.delete();
      });
    }
  }
}
