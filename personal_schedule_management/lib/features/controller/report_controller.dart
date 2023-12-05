import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/completed_work_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/report_responsitory_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/domain/entity/cong_viec_entity.dart';

class ReportController {
  ReportResponsitoryImpl reportResponsitoryImpl =
      GetIt.instance<ReportResponsitoryImpl>();
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  CompletedWorkRespositoryImpl completedWorkRespositoryImpl =
      GetIt.instance<CompletedWorkRespositoryImpl>();
  int numOfFinish = 0;
  int numOfUnFinish = 0;
  int numOfLate = 0;
  int totalNumOfWorks = 0;
  List<CongViecHT> congViecHT = [];

  Future<String> getAllNumberOfWorks() async {
    congViecHT = await completedWorkRespositoryImpl.getAllCompletedWork();
    congViecHT.forEach((element) {
      if (element.ngayHoanThanh.isBefore(element.ngayKetThuc) &&
          element.ngayKetThuc.isBefore(DateTime.now())) {
        numOfLate--;
      }
    });
    List<CongViec> congViecList =
        await workRespositoryImpl.getAllCongViecByUserId('');
    congViecList.forEach((element) {
      if (element.thoiDiemLap.isNotEmpty) {
        congViecHT
            .removeWhere((ht) => element.ngayNgoaiLe.contains(ht.ngayBatDau));

        List<DateTime> dateTaskList =
            SfCalendar.getRecurrenceDateTimeCollection(
                element.thoiDiemLap, element.ngayBatDau);
        dateTaskList.removeWhere((task) => element.ngayNgoaiLe.contains(task));
        totalNumOfWorks += dateTaskList.length;
        dateTaskList.forEach((element1) {
          DateTime ngayKetThuc =
              element1.add(element.ngayKetThuc.difference(element.ngayBatDau));

          if (ngayKetThuc.isBefore(DateTime.now())) {
            numOfLate++;
          }
        });
      } else {
        totalNumOfWorks += 1;
        if (element.ngayKetThuc.isBefore(DateTime.now())) {
          numOfLate++;
        }
      }
    });
    numOfFinish = congViecHT.length;
    numOfUnFinish = totalNumOfWorks - numOfFinish;
    return 'Hello';
  }
}
