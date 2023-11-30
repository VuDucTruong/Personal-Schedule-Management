abstract class ReportResponsitory {
  Future<int> getAllFinishedWorkByUserIdAndMonth(
      String userId, DateTime monthOfYear);
}
