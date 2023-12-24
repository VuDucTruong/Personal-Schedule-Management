import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_ht_entity.dart';
import 'package:personal_schedule_management/core/domain/entity/thong_bao_entity.dart';
import 'package:personal_schedule_management/features/controller/calendar_schedule_controller.dart';
import 'package:personal_schedule_management/features/controller/data_source_controller.dart';
import 'package:personal_schedule_management/features/controller/work_detail_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class InvitationDetailPage extends StatefulWidget {
  @override
  State<InvitationDetailPage> createState() => _InvitationDetailPageState();
  InvitationDetailPage(this.congViec, this.appointment, {super.key});
  CongViec congViec;
  Appointment appointment;
}

class _InvitationDetailPageState extends State<InvitationDetailPage> {
  late CongViec selectedCongViec;
  late DateFormat dayFormat;
  late DateFormat timeFormat;
  WorkDetailController controller = WorkDetailController();
  CalendarScheduleController calendarScheduleController =
      CalendarScheduleController();
  DataSourceController dataSourceController =
      GetIt.instance<DataSourceController>();
  late Future<CongViecHT?> getData;
  CongViecHT? congViecHT;
  @override
  void initState() {
    super.initState();
    selectedCongViec = widget.congViec;
    getData = getData_DateTimeFormat();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<CongViecHT?> getData_DateTimeFormat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String timeFormatString = (prefs.getBool(TIME_24H_FORMAT) ?? false)
        ? AppDateFormat.TIME_24H
        : AppDateFormat.TIME_12H;
    String dayFormatString =
        prefs.getString(DATE_FORMAT) ?? AppDateFormat.DAY_MONTH_YEAR;
    timeFormat = DateFormat(timeFormatString, 'vi_VN');
    dayFormat = DateFormat(dayFormatString, 'vi_VN');
    congViecHT = await controller.getCompletedWork(
        selectedCongViec.maCV, widget.appointment.startTime);
    completeStatus = (congViecHT != null);
    return congViecHT;
  }

  final List<String> options = ['Chỉnh sửa', 'Hoàn thành'];
  final String notSet = 'Chưa đặt';
  bool completeStatus = false;
  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    int times = 0;
    int timesRemove = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHI TIẾT LỜI MỜI\t',
          style: AppTextStyle.h2
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Người mời: ',
              style: AppTextStyle.normal
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 10),
            Text(
              'Ngày mời: ',
              style: AppTextStyle.normal
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 10),
            Text(
              'Nội dung công việc',
              style: AppTextStyle.normal
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              width: double.infinity,
              height: size.height / 2 + 20,
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
                                style: AppTextStyle.h2.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              Text('Ngày bắt đầu :',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                              Text(
                                '${dayFormat.format(widget.appointment.startTime)} ${selectedCongViec.isCaNgay ? '' : timeFormat.format(selectedCongViec.ngayBatDau)}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text('Ngày kết thúc :',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                              Text(
                                '${dayFormat.format(widget.appointment.endTime)} ${selectedCongViec.isCaNgay ? '' : timeFormat.format(selectedCongViec.ngayKetThuc)}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.priority_high, 'Độ ưu tiên'),
                            Text(
                              PRIORITY_MAP.keys
                                  .toList()[selectedCongViec.doUuTien - 1],
                              style: TextStyle(
                                color:
                                    COLOR_LEVEL[selectedCongViec.doUuTien - 1],
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.description, 'Chi tiết'),
                            Text(
                              selectedCongViec.noiDung.isNotEmpty
                                  ? selectedCongViec.noiDung
                                  : notSet,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary)),
                                      );
                                    }
                                  }
                                  return Text(notSet,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary));
                                }),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.repeat_on_rounded, 'Lặp lại'),
                            Text(
                              selectedCongViec.tenCK.isNotEmpty
                                  ? '${selectedCongViec.tenCK}\nThời điểm kết thúc lặp: ${controller.getDateTimeFromString(selectedCongViec.thoiDiemLap)}'
                                  : notSet,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.link, 'URL'),
                            Text(
                              selectedCongViec.url.isNotEmpty
                                  ? selectedCongViec.url
                                  : notSet,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            IconWithText(Icons.location_on, 'Vị trí'),
                            Text(
                              selectedCongViec.diaDiem.isNotEmpty
                                  ? selectedCongViec.diaDiem
                                  : notSet,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: size.width / 5 + 15,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.25),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Text(
                      'Đồng ý',
                      style: AppTextStyle.normal.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: size.width / 5 + 15,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.25),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Text(
                      'Từ chối',
                      style: AppTextStyle.normal.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
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
          style: AppTextStyle.h2_5
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        )
      ],
    );
  }
}
