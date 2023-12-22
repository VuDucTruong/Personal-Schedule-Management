import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';

import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';

import '../../core/domain/entity/cong_viec_ht_entity.dart';

class WorkDetailController {
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();
  List<ThongBao> thongBaoList = [];
  final DateFormat dateFormat2 = DateFormat('EE dd/MM/yyyy', 'vi_VN');
  Future<List<ThongBao>> getNotificationByWorkId(String maCV) async {
    thongBaoList = await workRespositoryImpl.getThongBaoListByWorkId(maCV);
    return thongBaoList;
  }

  String getDateTimeFromString(String thoiDiemLap) {
    String input = thoiDiemLap;

    List<String> parts = input.split(';');
    String datetimeString = '';
    for (String part in parts) {
      List<String> keyValue = part.split('=');
      DateTime datetime;

      if (keyValue.length == 2) {
        String key = keyValue[0];
        String value = keyValue[1];
        if (key == 'UNTIL') {
          String year = value.substring(0, 4);
          String month = value.substring(4, 6);
          String day = value.substring(6, 8);
          datetime =
              DateTime(int.parse(year), int.parse(month), int.parse(day));
          datetimeString = dateFormat2.format(datetime);
          break;
        }
      }
    }
    return datetimeString;
  }

  Future<bool> addCompletedWork(
      String maCV, DateTime startTime, DateTime endTime) async {
    CongViecHT congViecHT = CongViecHT(startTime, endTime, DateTime.now());
    await workRespositoryImpl.addCongViecHT(congViecHT, maCV);
    return true;
  }

  Future<bool> removeCompletedWork(String maCV, DateTime startTime) async {
    await workRespositoryImpl.removeCongViecHT(startTime, maCV);
    return true;
  }

  Future<CongViecHT?> getCompletedWork(String maCV, DateTime startTime) async {
    return await workRespositoryImpl.getCongViecHTByWorkId(maCV, startTime);
  }

  Future<void> deleteWork(String maCV) async {
    await workRespositoryImpl.deleteWorkById(maCV);
  }
}
