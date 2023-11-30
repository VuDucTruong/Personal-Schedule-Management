import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_dto.dart';
import 'package:personal_schedule_management/core/data/repository/work_respository.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';

class WorkRespositoryImpl extends WorkRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<String?> insertWorkToRemote(CongViec congViec) async {
    CongViecDTO insertWork = congViec.toCongViecDTO();
    insertWork.maND = _auth.currentUser?.uid ?? '';
    DocumentReference docRef =
        await _storage.collection(CONGVIEC).add(insertWork.toJson());
    if (docRef.id.isNotEmpty) {
      insertWork.maCV = docRef.id;
      await docRef.set(insertWork.toJson());
      return docRef.id;
    }
    return null;
  }

  Future<List<CongViec>> getAllCongViecByUserId(String userId) async {
    try {
      userId = _auth.currentUser?.uid ?? '';
    } catch (e) {
      print(e);
    }
    var data = await _storage
        .collection(CONGVIEC)
        .where('maND', isEqualTo: userId)
        .get();
    List<CongViec> congViecList = [];
    data.docs.forEach((element) {
      CongViecDTO congViecDTO =
          CongViecDTO.fromJson(element.data(), element.id);
      congViecList.add(congViecDTO.toCongViec());
    });
    return congViecList;
  }

  @override
  Future<void> deleteWorkById(String maCV) async {
    await _storage.collection(CONGVIEC).doc(maCV).delete();
  }

  @override
  Future<CongViec?> getCongViecById(String maCV) async {
    var data = await _storage
        .collection(CONGVIEC)
        .where('maCV', isEqualTo: maCV)
        .get();
    if (data.docs.isEmpty) {
      return null;
    }
    CongViecDTO congViecDTO =
        CongViecDTO.fromJson(data.docs.first.data(), data.docs.first.id);
    return congViecDTO.toCongViec();
  }

  @override
  Future<String?> updateWorkToRemote(CongViec congViec) async {
    CongViecDTO insertWork = congViec.toCongViecDTO();
    if (congViec.maCV.isNotEmpty) {
      await _storage
          .collection(CONGVIEC)
          .doc(congViec.maCV)
          .update(insertWork.toJson());
      return congViec.maCV;
    }
    return null;
  }

  @override
  Future<void> updateTinhTrangWork(String maCV, int trangThai) async {
    var data = await _storage.collection(CONGVIEC).doc(maCV);
    await data.update({'trangThai': trangThai});
  }
}
