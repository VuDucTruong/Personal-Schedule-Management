import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/dto/chu_ky_dto.dart';
import 'package:personal_schedule_management/core/data/repository/recurrence_respository.dart';
import 'package:personal_schedule_management/core/domain/entity/chu_ky_entity.dart';

class RecurrenceRespositoryImpl extends RecurrenceRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<String?> insertRecurrenceWorkToRemote(ChuKy chuKy) async {
    // TODO: implement insertRecurrenceWorkToRemote
    ChuKyDTO chuKyDTO = chuKy.toChuKyDTO();
    DocumentReference docRef =
        await _storage.collection(CHUKY).add(chuKyDTO.toJson());
    if (docRef.id.isNotEmpty) return docRef.id;
    return null;
  }
}
