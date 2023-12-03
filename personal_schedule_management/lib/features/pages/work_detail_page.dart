import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/core/domain/entity/cong_viec_entity.dart';
import 'package:personal_schedule_management/features/controller/work_detail_controller.dart';
import 'package:personal_schedule_management/features/pages/create_work_page.dart';

import '../../core/domain/entity/cong_viec_ht_entity.dart';
import '../../core/domain/entity/thong_bao_entity.dart';

class WorkDetailPage extends StatefulWidget {
  @override
  _WorkDetailPageState createState() {
    return _WorkDetailPageState();
  }

  WorkDetailPage(this.congViec, this.startDay, this.endDay, {super.key});
  CongViec congViec;
  DateTime startDay;
  DateTime endDay;
}

class _WorkDetailPageState extends State<WorkDetailPage> {
  late CongViec selectedCongViec;
  late DateFormat dayFormat;
  WorkDetailController controller = WorkDetailController();
  @override
  void initState() {
    super.initState();
    selectedCongViec = widget.congViec;
    if (selectedCongViec.isCaNgay) {
      dayFormat = DateFormat('EE, dd/MM/yyyy', 'vi_VN');
    } else
      dayFormat = DateFormat("EE, dd/MM/yyyy hh:mm a", 'vi_VN');
  }

  @override
  void dispose() {
    super.dispose();
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
      future:
          controller.getCompletedWork(selectedCongViec.maCV, widget.startDay),
      builder: (context, snapshot) {
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
                color: lightColorScheme.primary,
              ),
              actions: [
                PopupMenuButton(
                  offset: Offset(0, 30),
                  icon: Icon(
                    Icons.more_horiz,
                    color: lightColorScheme.primary,
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
                                selectedCongViec.maCV, widget.startDay);
                          } else {
                            await controller.addCompletedWork(
                                selectedCongViec.maCV,
                                widget.startDay,
                                widget.endDay);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Cập nhật trạng thái thành công')));
                          setState(() {
                            isChange = true;
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Chỉnh sửa'),
                        value: 'Chỉnh sửa',
                        onTap: () async {
                          List<dynamic> results = await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                CreateWorkPage(selectedCongViec),
                          );
                          if (results.length > 1 && results[0]) {
                            setState(() {
                              isChange = true;
                              selectedCongViec = results[1];
                            });
                          }
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Xóa'),
                        value: 'Xóa',
                        onTap: () async {
                          if (timesRemove > 0) return;
                          String title = selectedCongViec.thoiDiemLap.isNotEmpty
                              ? 'Xóa công việc lặp lại'
                              : 'Xóa công việc';
                          bool result = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(title),
                                  actions: [
                                    FilledButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: Text('OK')),
                                    FilledButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: Text('Hủy'))
                                  ],
                                ),
                              ) ??
                              false;
                          if (!result) return;
                          timesRemove++;
                          await controller.deleteWork(selectedCongViec.maCV);
                          isChange = true;
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
                              '${dayFormat.format(selectedCongViec.ngayBatDau)}',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            Text(
                              'Ngày kết thúc :',
                            ),
                            Text(
                              '${dayFormat.format(selectedCongViec.ngayKetThuc)}',
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
                                    style:
                                        TextStyle(color: Colors.grey.shade600));
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
      },
    );
  }

  Widget IconWithText(IconData iconData, String text) {
    return Row(
      children: [
        Icon(
          iconData,
          color: lightColorScheme.primary,
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
