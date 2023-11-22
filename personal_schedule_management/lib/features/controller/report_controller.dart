import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/report_responsitory_impl.dart';

class ReportController extends ChangeNotifier {
  ReportResponsitoryImpl reportResponsitoryImpl =
      GetIt.instance<ReportResponsitoryImpl>();
  int numOfFinishedWork = 0;
  void fetchData(DateTime monthOfYear) {
    reportResponsitoryImpl.getAllFinishedWorkByUserIdAndMonth('', monthOfYear);
  }
}
