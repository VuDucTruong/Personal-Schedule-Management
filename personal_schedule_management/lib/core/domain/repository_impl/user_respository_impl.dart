import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/dto/nguoi_dung_dto.dart';
import 'package:personal_schedule_management/core/data/repository/user_respository.dart';
import 'package:personal_schedule_management/core/domain/entity/nguoi_dung_entity.dart';

import '../../constants/constants.dart';

class UserRespositoryImpl extends UserRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<void> addUser(NguoiDung nguoiDung) async {
    await _storage
        .collection(NGUOIDUNG)
        .doc(nguoiDung.maND)
        .set(nguoiDung.toNguoiDungDTO().toJson());
  }

  @override
  Future<String> getUserEmailById(String maND) async {
    var docRef = await _storage.collection(NGUOIDUNG).doc(maND).get();
    NguoiDung? nguoiDung;
    try {
      nguoiDung =
          NguoiDungDTO.fromJson(docRef.data()!, docRef.id).toNguoiDung();
    } catch (e) {
      print(e);
    }
    if (nguoiDung != null) {
      return nguoiDung.email;
    } else {
      return '';
    }
  }

  @override
  Future<List<String>> getAllUserEmail() async {
    var docRef = await _storage.collection(NGUOIDUNG).get();
    print(docRef.docs.map((doc) => doc.data()));
    return [];
  }
}
