import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/data/repository/user_respository.dart';

class UserRespositoryImpl implements UserRespository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<void> userLogin() {
    // TODO: implement userLogin
    throw UnimplementedError();
  }
}
