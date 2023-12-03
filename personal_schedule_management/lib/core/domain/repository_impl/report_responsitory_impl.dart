import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/data/repository/report_responsitory.dart';

class ReportResponsitoryImpl extends ReportResponsitory {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  @override
  Future<int> getAllFinishedWorkByUserIdAndMonth(
      String userId, DateTime monthOfYear) async {
    var data = await _storage
        .collection(CONGVIEC)
        .where('maND', isEqualTo: userId)
        .where('trangThai', isEqualTo: 1)
        .where('ngayBatDau',
            isGreaterThanOrEqualTo: Timestamp.fromDate(monthOfYear),
            isLessThanOrEqualTo: Timestamp.fromDate(
                monthOfYear.copyWith(month: monthOfYear.month + 1)))
        .get();
    return data.docs.length;
  }
}
