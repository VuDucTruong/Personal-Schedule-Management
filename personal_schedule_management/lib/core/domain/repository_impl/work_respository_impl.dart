import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/dto/cong_viec_dto.dart';
import 'package:personal_schedule_management/core/data/repository/work_respository.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';

class WorkRespositoryImpl extends WorkRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<String?> insertWorkToRemote(CongViec congViec) async {
    CongViecDTO insertWork = congViec.toCongViecDTO();
    DocumentReference docRef =
        await _storage.collection(CONGVIEC).add(insertWork.toJson());
    if (docRef.id.isNotEmpty) return docRef.id;
    return null;
  }
}
