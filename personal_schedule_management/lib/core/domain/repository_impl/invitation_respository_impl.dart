import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/dto/thu_moi_dto.dart';
import 'package:personal_schedule_management/core/data/repository/invitation_respository.dart';
import 'package:personal_schedule_management/core/domain/entity/thu_moi_entity.dart';

class InvitationRespositoryImpl extends InvitationRespository {
  FirebaseFirestore _storage = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? get _currentUser => _auth.currentUser;
  @override
  Future<String> addInvitation(ThuMoi thuMoi) async {
    var docRef =
        await _storage.collection(THUMOI).add(thuMoi.toThuMoiDTO().toJson());
    return docRef.id;
  }

  @override
  Future<void> deleleInvitationById(String maTM) async {
    await _storage.collection(THUMOI).doc(maTM).delete();
  }

  @override
  Future<List<ThuMoi>> getAllInvitaions() async {
    var snapShot = await _storage
        .collection(THUMOI)
        .where('maKM', isEqualTo: _currentUser?.uid ?? '')
        .get();
    List<ThuMoi> thuMoiList = [];
    for (var element in snapShot.docs) {
      thuMoiList.add(ThuMoiDTO.fromJson(element.data(), element.id).toThuMoi());
    }
    return thuMoiList;
  }

  @override
  Future<void> updateInvitationStatus(ThuMoi thuMoi) async {
    await _storage
        .collection(THUMOI)
        .doc(thuMoi.maTM)
        .update({'tinhTrang': thuMoi.tinhTrang});
  }
}
