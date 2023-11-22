import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';
import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/notification_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/recurrence_respository_impl.dart';
import 'package:personal_schedule_management/core/domain/repository_impl/work_respository_impl.dart';
import 'package:personal_schedule_management/features/widgets/stateful/create_recurrence_dialog.dart';
import 'package:personal_schedule_management/features/widgets/stateless/reminder_dialog.dart';

import '../../config/theme/app_theme.dart';
import '../../core/domain/entity/chu_ky_entity.dart';

class CreateWorkController {
  int selectedColorRadio = 0;
  bool allDaySwitch = false;
  bool alarmSwitch = false;
  bool reminderSwitch = true;
  String priorityValue = 'Trung bình';
  List<dynamic> reminderValueList = [];
  String selectedValue = 'Không có';
  DateTime? startDate, endDate;
  List<String> reminderTimeList = [];
  late List<String> contentRecurrence;
  Map<String, dynamic>? loop;
  Color colorIcon = lightColorScheme.primary;
  DateTime currentDate = DateTime.now();
  RecurrenceRespositoryImpl recurrenceRespositoryImpl =
      GetIt.instance<RecurrenceRespositoryImpl>();
  NotificationRespositoryImpl notificationRespositoryImpl =
      GetIt.instance<NotificationRespositoryImpl>();
  WorkRespositoryImpl workRespositoryImpl =
      GetIt.instance<WorkRespositoryImpl>();

  CreateWorkController() {
    startDate = currentDate;
    endDate = currentDate.add(Duration(hours: 1));
  }

  void onChangedColorRadio(Color color) {
    colorIcon = color;
  }

  void changeAllDaySwitch(bool value) {
    allDaySwitch = value;
  }

  void changeReminderSwitch(bool value) {
    reminderSwitch = value;
  }

  void changeAlarmSwitch(value) {
    alarmSwitch = value;
  }

  Future<void> createNotification(String maCV) async {
    if (reminderValueList.isNotEmpty) {
      reminderValueList.forEach((element) {
        ThongBao thongBao = ThongBao('', maCV, alarmSwitch ? 1 : 0, element);
        notificationRespositoryImpl.insertNotificationToRemote(thongBao);
      });
    }
  }

  Future<bool> createWork(CongViec congViec) async {
    String? maCK;
    if (loop != null) {
      Map<String, dynamic> data = loop?['data'] ?? {};
      if (data.isNotEmpty) {
        String thoiDiemLap = '';
        final DateFormat dateFormat = DateFormat('yyyyMMdd\'T\'HHmmss\'Z\'');
        switch (loop?['type']) {
          case 'DAILY':
            thoiDiemLap = 'FREQ=${loop?['type']};INTERVAL=${data['dayNumber']}';
            break;
          case 'WEEKLY':
            thoiDiemLap =
                'FREQ=${loop?['type']};INTERVAL=${data['weekNumber']}';
            List<dynamic>? weekDaysList = data['weekDays'];
            if (weekDaysList != null) {
              String byDay = weekDaysList.reduce((value, element) {
                return '${weekDaysMap[value] ?? value},${weekDaysMap[element]}';
              });

              thoiDiemLap += ';BYDAY=$byDay';
            }
            break;
          case 'MONTHLY':
            thoiDiemLap =
                'FREQ=${loop?['type']};INTERVAL=1;BYMONTHDAY=${startDate?.day}';
            break;
          case 'YEARLY':
            thoiDiemLap =
                'FREQ=${loop?['type']};INTERVAL=1;BYMONTHDAY=${startDate?.day};BYMONTH=${startDate?.month}';
            break;
        }
        if (data['endDate'] != null)
          thoiDiemLap += ';UNTIL=${dateFormat.format(data['endDate'])}';
        ChuKy chuKy = ChuKy('', contentRecurrence[0], thoiDiemLap);
        maCK =
            await recurrenceRespositoryImpl.insertRecurrenceWorkToRemote(chuKy);
      }
    }
    congViec.maCK = maCK ?? '';
    String? maCV = await workRespositoryImpl.insertWorkToRemote(congViec);
    if (maCV != null) {
      createNotification(maCV);
      return true;
    }
    return false;
  }

  Future<void> pickUpStartDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(currentDate.year + 20));
    if (selectedDate != null) {
      startDate = startDate!.copyWith(
          year: selectedDate.year,
          month: selectedDate.month,
          day: selectedDate.day);
      if (startDate!.compareTo(endDate!) > 0) endDate = startDate;
    }
  }

  Future<void> pickUpEndDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: startDate!,
        firstDate: startDate!,
        lastDate: DateTime(startDate!.year + 20));
    if (selectedDate != null) {
      endDate = endDate!.copyWith(
          year: selectedDate.year,
          month: selectedDate.month,
          day: selectedDate.day);
    }
  }

  Future<void> pickUpStartTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: startDate!.hour, minute: startDate!.minute));
    if (selectedTime != null) {
      DateTime temp = startDate!.copyWith(
          hour: selectedTime.hour,
          minute: selectedTime.minute); // start time moi
      if (temp.compareTo(endDate!) > 0) {
        startDate = endDate = temp;
      } else {
        startDate = temp;
      }
    }
  }

  Future<void> pickUpEndTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: endDate!.hour, minute: endDate!.minute));

    if (selectedTime != null) {
      DateTime temp = endDate!
          .copyWith(hour: selectedTime.hour, minute: selectedTime.minute);
      if (temp.compareTo(startDate!) >= 0) {
        endDate = temp;
      }
    }
  }

  Future<void> insertReminderTime(BuildContext context) async {
    List<dynamic>? results;
    if (allDaySwitch) {
      results = await showDialog(
        context: context,
        builder: (context) =>
            ReminderDialog(true, REMINDER_DAY_LIST, startDate!),
      );
    } else {
      results = await showDialog(
        context: context,
        builder: (context) => ReminderDialog(false, REMINDER_LIST, startDate!),
      );
    }
    if (results != null && !reminderTimeList.contains(results[0])) {
      reminderTimeList.add(results[0]);
      reminderValueList.add(results[1]);
    }
  }

  void deleteReminderTime(int index) {
    reminderTimeList.removeAt(index);
  }

  void changeStringValue(String newValue) {
    selectedValue = newValue;
  }

  Future<void> openRecurringDialog(BuildContext context) async {
    Map<String, dynamic> temp = await showDialog(
            context: context,
            builder: (context) => CreateRecurrenceDialog(startDate)) ??
        {};
    if (temp.isNotEmpty) {
      loop = temp;
      _extractData(loop?['type'], loop?['data']);
    }
  }

  void _extractData(String type, Map<String, dynamic> data) {
    contentRecurrence = [];
    DateTime? dateTime = data['endDate'];
    switch (type) {
      case 'DAILY':
        contentRecurrence.add('Lặp lại mỗi ${data['dayNumber']} ngày');
        break;
      case 'WEEKLY':
        List<dynamic> weekDaysList = data['weekDays'];
        weekDaysList.sort();
        contentRecurrence.add(
            'Lặp lại ${weekDaysList.reduce((value, element) => '$value,$element')} mỗi ${data['weekNumber']} tuần');
        break;
      case "MONTHLY":
        contentRecurrence.add('Lặp lại ngày ${startDate?.day} mỗi tháng');
        break;
      case "YEARLY":
        contentRecurrence.add(
            'Lặp lại vào ngày ${startDate?.day}/${startDate?.month} mỗi năm');
        break;
    }
    if (dateTime != null) {
      contentRecurrence.add(
          'Kết thúc lặp : ${dateTime.day}/${dateTime.month}/${dateTime.year}');
    } else {
      contentRecurrence.add('Vô hạn');
    }
  }

  void changePriorityValue(String value) {
    priorityValue = value;
  }

  void removeLoop() {
    loop = null;
  }
}
