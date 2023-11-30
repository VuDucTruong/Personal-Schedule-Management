import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_ht_dto.dart';
import 'package:personal_schedule_management/core/data/repository/completed_work_respository.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';

class CompletedWorkRespositoryImpl extends CompletedWorkRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<String?> insertCompletedWork(CongViecHT congViecHT) async {
    CongViecHTDTO congViecHTDTO = congViecHT.toCongViecHTDTO();
    var docRef = await _storage
        .collection(CONGVIEC)
        .doc(congViecHT.maCV)
        .collection(CONGVIECHT)
        .add(congViecHTDTO.toJson());
    if (docRef.id.isNotEmpty) {
      return docRef.id;
    }
    return null;
  }

  @override
  Future<void> deleteCompletedWork(String maCV, DateTime startDay) async {
    var docRef = await _storage
        .collection(CONGVIEC)
        .doc(maCV)
        .collection(CONGVIECHT)
        .where('ngayBatDau', isEqualTo: Timestamp.fromDate(startDay))
        .get();
    try {
      String path = docRef.docs.first.id;
      await _storage
          .collection(CONGVIEC)
          .doc(maCV)
          .collection(CONGVIECHT)
          .doc(path)
          .delete();
    } catch (e) {}
  }

  @override
  Future<CongViecHT> getCompletedWork(String maCV, DateTime startDay) async {
    var docRef = await _storage
        .collection(CONGVIEC)
        .doc(maCV)
        .collection(CONGVIECHT)
        .where('ngayBatDau', isEqualTo: Timestamp.fromDate(startDay))
        .get();
    CongViecHTDTO congViecHTDTO =
        CongViecHTDTO.fromJson(docRef.docs.first.data(), docRef.docs.first.id);
    return congViecHTDTO.toCongViecHT();
  }

  @override
  Future<List<CongViecHT>> getAllCompletedWork() async {
    List<CongViecHT> congViecHTList = [];
    var docRef =
        await _storage.collection(CONGVIEC).where('maND', isEqualTo: '').get();

    for (var element in docRef.docs) {
      var docRef2 = await _storage
          .collection(CONGVIEC)
          .doc(element.id)
          .collection(CONGVIECHT)
          .get();

      docRef2.docs.forEach((element2) {
        CongViecHTDTO congViecHTDTO =
            CongViecHTDTO.fromJson(element2.data(), element2.id);
        congViecHTList.add(congViecHTDTO.toCongViecHT());
      });
    }
    return congViecHTList;
  }
}
