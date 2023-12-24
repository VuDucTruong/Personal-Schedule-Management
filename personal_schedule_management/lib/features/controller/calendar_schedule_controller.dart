import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:personal_schedule_management/features/pages/calendar%20pages/work_detail_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/domain/entity/cong_viec_entity.dart';

class CalendarScheduleController {
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  Map<String, CongViecHT> congViecHTMap = {};
  Map<String, bool> checkBoxMap = {};
  Future<void> showWorkDetails(BuildContext context, Appointment appointment,
      VoidCallback setState) async {
    CongViec? congViec =
        await workRespositoryImpl.getCongViecById(appointment.id.toString());
    if (congViec != null) {
      bool result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkDetailPage(congViec, appointment),
              )) ??
          false;
      if (result) setState();
    }
  }

  Future<void> getAllCompletedWork(VoidCallback setStateCallStack) async {
    checkBoxMap.clear();
    List<CongViec> congViecList =
        await workRespositoryImpl.getAllCongViecByUserId('');
    List<CongViecHT> list = [];
    for (var element in congViecList) {
      if (element.congViecHTList.isNotEmpty) {
        list.addAll(element.congViecHTList);
      }
    }
    for (var element in list) {
      String key = '${element.ngayBatDau}';
      congViecHTMap[key] = element;
      checkBoxMap[key] = true;
    }
    setStateCallStack();
  }

  Future<bool> addCompletedWork(Appointment appointment) async {
    CongViecHT congViecHT =
        CongViecHT(appointment.startTime, appointment.endTime, DateTime.now());
    await workRespositoryImpl.addCongViecHT(
        congViecHT, appointment.id.toString());
    return true;
  }

  Future<bool> removeCompletedWork(String maCV, DateTime startTime) async {
    await workRespositoryImpl.removeCongViecHT(startTime, maCV);
    return true;
  }

  Future<CongViecHT?> getCompletedWork(String maCV, DateTime startTime) async {
    return await workRespositoryImpl.getCongViecHTByWorkId(maCV, startTime);
  }

  Future<void> removeWork(String maCV) async {
    await workRespositoryImpl.deleteWorkById(maCV);
  }

  Future<void> addExceptionInWork(String maCV, DateTime exception) async {
    await workRespositoryImpl.addException(maCV, exception);
  }
}
