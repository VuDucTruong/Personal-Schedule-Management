import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/completed_work_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:personal_schedule_management/features/pages/work_detail_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/domain/entity/cong_viec_entity.dart';

class CalendarScheduleController {
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  CompletedWorkRespositoryImpl completedWorkRespositoryImpl =
      GetIt.instance<CompletedWorkRespositoryImpl>();
  Map<String, CongViecHT> congViecHTMap = {};
  Map<String, bool> checkBoxMap = {};
  Future<void> showWorkDetails(BuildContext context, Appointment appointment,
      VoidCallback voidCallback) async {
    CongViec? congViec =
        await workRespositoryImpl.getCongViecById(appointment.id.toString());
    if (congViec != null) {
      bool? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkDetailPage(
                congViec, appointment.startTime, appointment.endTime),
          ));
      if (result != null && result) {
        voidCallback();
      }
    }
  }

  Future<void> getAllCompletedWork(VoidCallback setStateCallStack) async {
    checkBoxMap.clear();
    List<CongViecHT> list =
        await completedWorkRespositoryImpl.getAllCompletedWork();
    list.forEach((element) {
      String key = '${element.maCV}-${element.ngayBatDau}';
      congViecHTMap[key] = element;
      checkBoxMap['${element.ngayBatDau}'] = true;
    });
    setStateCallStack();
  }

  Future<bool> addCompletedWork(Appointment appointment) async {
    CongViecHT congViecHT = CongViecHT('', appointment.id.toString(),
        appointment.startTime, appointment.endTime, DateTime.now());
    await completedWorkRespositoryImpl.insertCompletedWork(congViecHT);
    return true;
  }

  Future<bool> removeCompletedWork(String maCV, DateTime startTime) async {
    await completedWorkRespositoryImpl.deleteCompletedWork(maCV, startTime);
    return true;
  }

  Future<CongViecHT> getCompletedWork(String maCV, DateTime startTime) async {
    return await completedWorkRespositoryImpl.getCompletedWork(maCV, startTime);
  }
}
