import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:personal_schedule_management/features/controller/data_source_controller.dart';
import 'package:personal_schedule_management/features/controller/work_detail_controller.dart';
import 'package:personal_schedule_management/features/pages/create_work_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/domain/entity/cong_viec_ht_entity.dart';
import '../../core/domain/entity/thong_bao_entity.dart';
import '../widgets/stateless/delete_dialog.dart';

class WorkDetailPage extends StatefulWidget {
  @override
  _WorkDetailPageState createState() {
    return _WorkDetailPageState();
  }

  WorkDetailPage(this.congViec, this.appointment, {super.key});
  CongViec congViec;
  Appointment appointment;
}

class _WorkDetailPageState extends State<WorkDetailPage> {
  late CongViec selectedCongViec;
  late DateFormat dayFormat;
  WorkDetailController controller = WorkDetailController();
  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();
  DataSourceController dataSourceController =
      GetIt.instance<DataSourceController>();
  @override
  void initState() {
    super.initState();
    selectedCongViec = widget.congViec;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<CongViecHT> getData_DateTimeFormat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String timeFormatString = (prefs.getBool(TIME_24H_FORMAT) ?? false)
        ? AppDateFormat.TIME_24H
        : AppDateFormat.TIME_12H;
    String dayFormatString =
        prefs.getString(DATE_FORMAT) ?? AppDateFormat.DAY_MONTH_YEAR;
    if (selectedCongViec.isCaNgay) {
      dayFormat = DateFormat(dayFormatString, 'vi_VN');
    } else {
      dayFormat = DateFormat("$dayFormatString $timeFormatString", 'vi_VN');
    }
    return await controller.getCompletedWork(
        selectedCongViec.maCV, widget.appointment.startTime);
  }

  final List<String> options = ['Chỉnh sửa', 'Hoàn thành'];
  final String notSet = 'Chưa đặt';
  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    int times = 0;
    int timesRemove = 0;
    return FutureBuilder(
      future: getData_DateTimeFormat(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          CongViecHT? congViecHT = snapshot.data;
          String complete =
              (congViecHT == null ? 'Hoàn thành' : 'Chưa hoàn thành');
          return Scaffold(
            appBar: AppBar(
                title: Text(
                  selectedCongViec.tieuDe,
                  overflow: TextOverflow.ellipsis,
                ),
                centerTitle: true,
                leading: InkWell(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    Navigator.pop(context, isChange);
                  },
                ),
                iconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.primary,
                ),
                actions: [
                  PopupMenuButton(
                    offset: Offset(0, 30),
                    icon: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text(complete),
                          value: complete,
                          onTap: () async {
                            if (times++ > 0) return;
                            if (congViecHT != null) {
                              await controller.removeCompletedWork(
                                  selectedCongViec.maCV,
                                  widget.appointment.startTime);
                            } else {
                              await controller.addCompletedWork(
                                  selectedCongViec.maCV,
                                  widget.appointment.startTime,
                                  widget.appointment.endTime);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Cập nhật trạng thái thành công')));
                            setState(() {
                              isChange = true;
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Chỉnh sửa'),
                          value: 'Chỉnh sửa',
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) =>
                                  CreateWorkPage(selectedCongViec),
                            );
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Xóa'),
                          value: 'Xóa',
                          onTap: () async {
                            if (timesRemove > 0) return;
                            if ((selectedCongViec.thoiDiemLap.isNotEmpty)) {
                              int result = await showDialog(
                                    context: context,
                                    builder: (context) => DeleteDialog(),
                                  ) ??
                                  0;
                              if (result == 0) return;
                              if (result == 1) {
                                await calendarScheduleController
                                    .removeWork(selectedCongViec.maCV);
                                dataSourceController
                                    .removeAppointment(widget.appointment);
                              } else {
                                await calendarScheduleController
                                    .addExceptionInWork(selectedCongViec.maCV,
                                        widget.appointment.startTime);
                                if (widget
                                        .appointment.recurrenceExceptionDates !=
                                    null) {
                                  widget.appointment.recurrenceExceptionDates
                                      ?.add(widget.appointment.startTime);
                                } else {
                                  widget.appointment.recurrenceExceptionDates =
                                      [widget.appointment.startTime];
                                }
                                dataSourceController
                                    .updateAppointment(widget.appointment);
                              }
                            } else {
                              bool result = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text('Xóa công việc này ?'),
                                      actions: [
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: Text('OK'),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text('Hủy'),
                                        )
                                      ],
                                    ),
                                  ) ??
                                  false;
                              if (result) {
                                await calendarScheduleController
                                    .removeWork(selectedCongViec.maCV);
                                dataSourceController
                                    .removeAppointment(widget.appointment);
                              }
                            }
                            timesRemove++;
                            Navigator.pop(context, isChange);
                          },
                        ),
                      ];
                    },
                  )
                ]),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedCongViec.tieuDe,
                                style: AppTextStyle.h2,
                              ),
                              Text(
                                'Ngày bắt đầu :',
                              ),
                              Text(
                                '${dayFormat.format(widget.appointment.startTime)}',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              Text(
                                'Ngày kết thúc :',
                              ),
                              Text(
                                '${dayFormat.format(widget.appointment.endTime)}',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconWithText(Icons.category, 'Loại công việc'),
                            Text(
                              selectedCongViec.loaiCongViec.isNotEmpty
                                  ? selectedCongViec.loaiCongViec
                                  : notSet,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.priority_high, 'Độ ưu tiên'),
                            Text(
                              PRIORITY_MAP.keys
                                  .toList()[selectedCongViec.doUuTien - 1],
                              style: TextStyle(
                                  color: COLOR_LEVEL[
                                      selectedCongViec.doUuTien - 1],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.description, 'Chi tiết'),
                            Text(
                              selectedCongViec.noiDung.isNotEmpty
                                  ? selectedCongViec.noiDung
                                  : notSet,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(FontAwesomeIcons.bell, 'Nhắc nhở'),
                            FutureBuilder(
                                future: controller.getNotificationByWorkId(
                                    selectedCongViec.maCV),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<ThongBao>? list = snapshot.data;
                                    if (list != null && list.isNotEmpty) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: list.length,
                                        itemBuilder: (context, index) => Text(
                                            list[index].tenTB,
                                            style: TextStyle(
                                                color: Colors.grey.shade600)),
                                      );
                                    }
                                  }
                                  return Text(notSet,
                                      style: TextStyle(
                                          color: Colors.grey.shade600));
                                }),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.repeat_on_rounded, 'Lặp lại'),
                            Text(
                              selectedCongViec.tenCK.isNotEmpty
                                  ? '${selectedCongViec.tenCK}\nThời điểm kết thúc lặp: ${controller.getDateTimeFromString(selectedCongViec.thoiDiemLap)}'
                                  : notSet,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.link, 'URL'),
                            Text(
                              selectedCongViec.url.isNotEmpty
                                  ? selectedCongViec.url
                                  : notSet,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.location_on, 'Vị trí'),
                            Text(
                              selectedCongViec.diaDiem.isNotEmpty
                                  ? selectedCongViec.diaDiem
                                  : notSet,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget IconWithText(IconData iconData, String text) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: AppTextStyle.h2_5,
        )
      ],
    );
  }
}
