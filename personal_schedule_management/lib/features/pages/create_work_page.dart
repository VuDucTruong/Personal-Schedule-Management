import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/controller/create_work_controller.dart';
import 'package:personal_schedule_management/features/pages/work_category_page.dart';

import '../../core/domain/entity/cong_viec_entity.dart';

class CreateWorkPage extends StatefulWidget {
  CreateWorkPage(this.selectedCongViec, {super.key});
  CongViec? selectedCongViec;
  @override
  _CreateWorkPageState createState() {
    return _CreateWorkPageState();
  }
}

class _CreateWorkPageState extends State<CreateWorkPage> {
  late TextEditingController titleController,
      descriptionController,
      locationController,
      urlController;
  final _formKey = GlobalKey<FormState>();
  List<Color> colorList = [
    lightColorScheme.primary,
    Color.fromRGBO(232, 56, 56, 0.81),
    Color.fromRGBO(56, 232, 216, 0.81),
    Color.fromRGBO(186, 56, 232, 0.81),
    Color.fromRGBO(189, 232, 56, 0.81),
  ];
  Map<String, int> priorityMap = {
    'Cao nhất': 1,
    'Cao': 2,
    'Trung bình': 3,
    'Thấp': 4,
    'Thấp nhất': 5
  };
  DateFormat dayFormat = DateFormat("EE, dd/MM/yyyy", 'vi_VN');
  DateFormat time12Format = DateFormat("hh:mm a", 'vi_VN');
  DateFormat time24Format = DateFormat("HH:mm", 'vi_VN');
  late List<String> priorityList;
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
          datetimeString = dayFormat.format(datetime);
          break;
        }
      }
    }
    return datetimeString;
  }

  CreateWorkController createWorkController = CreateWorkController();
  @override
  void initState() {
    super.initState();
    priorityList = priorityMap.keys.toList();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    urlController = TextEditingController();
    if (widget.selectedCongViec != null) {
      CongViec congViec = widget.selectedCongViec!;
      titleController.text = congViec.tieuDe;
      descriptionController.text = congViec.noiDung;
      locationController.text = congViec.diaDiem;
      urlController.text = congViec.url;
      createWorkController.colorIcon = congViec.mauSac;
      createWorkController.startDate = congViec.ngayBatDau;
      createWorkController.endDate = congViec.ngayKetThuc;
      createWorkController.priorityValue = priorityList[congViec.doUuTien - 1];
      createWorkController.allDaySwitch = congViec.isCaNgay;
      createWorkController.selectedValue = congViec.loaiCongViec;
      if (congViec.tenCK.isNotEmpty) {
        createWorkController.contentRecurrence.add(congViec.tenCK);
        createWorkController.contentRecurrence
            .add(getDateTimeFromString(congViec.thoiDiemLap));
        createWorkController.loop = {};
      }
      createWorkController.fulfillReminderList(
          congViec.maCV, () => setState(() {}));
    }
  }

  Future<bool> chooseAction(CongViec congViec) async {
    bool results = false;
    if (widget.selectedCongViec != null) {
      if (await createWorkController.updateWork(congViec)) {
        results = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sửa thành công')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sửa thất bại')));
      }
    } else {
      if (await createWorkController.createWork(congViec)) {
        results = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Thêm thành công')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Thêm thất bại')));
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(8),
      height: height * 5 / 6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 4, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(FontAwesomeIcons.arrowLeftLong,
                        color: lightColorScheme.primary),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Công việc',
                    style: AppTextStyle.h2,
                  ),
                  InkWell(
                    child: Icon(FontAwesomeIcons.check,
                        color: lightColorScheme.primary),
                    onTap: () async {
                      try {
                        if (!_formKey.currentState!.validate()) return;
                      } catch (e) {
                        return;
                      }

                      CongViec congViec = CongViec(
                          widget.selectedCongViec?.maCV ?? '',
                          '',
                          titleController.text,
                          descriptionController.text,
                          createWorkController.selectedValue,
                          createWorkController.startDate!,
                          createWorkController.endDate!,
                          createWorkController.allDaySwitch,
                          priorityMap[createWorkController.priorityValue]!,
                          createWorkController.colorIcon,
                          locationController.text,
                          urlController.text,
                          false,
                          widget.selectedCongViec?.tenCK ?? '',
                          widget.selectedCongViec?.thoiDiemLap ?? '',
                          createWorkController.alarmSwitch);
                      bool result = await chooseAction(congViec);
                      Navigator.pop(context, result);
                    },
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.all(4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: titleController,
                              validator: (value) {
                                if (value != null && value.isNotEmpty)
                                  return null;
                                else
                                  return 'Không được bỏ trống !';
                              },
                              maxLines: 2,
                              minLines: 1,
                              decoration: InputDecoration(
                                  hintText: 'Tiêu đề',
                                  border: InputBorder.none),
                              style: AppTextStyle.h2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 100,
                      child: TextFormField(
                        controller: descriptionController,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        decoration: InputDecoration(
                            hintText: 'Thêm chi tiết',
                            border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
            ),
            OptionWork()
          ],
        ),
      ),
    );
  }

  Widget OptionWork() {
    int index = 0;
    return Card(
      elevation: 5,
      child: Column(children: [
        Container(
          child: Column(
            children: [
              ListTitleWork(
                Text('Loại công việc'),
                Icons.category,
                InkWell(
                  child: Container(
                    width: 120,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            createWorkController.selectedValue,
                            style: AppTextStyle.h2_5
                                .copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  onTap: () async {
                    List<String> result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkCategoryPage(
                              createWorkController.selectedValue)),
                    );
                    setState(() {
                      createWorkController.changeStringValue(result.first);
                    });
                  },
                ),
              ),
              DividerWorkItem(),
              ListTitleWork(
                  Text('Độ ưu tiên'),
                  Icons.priority_high,
                  Container(
                    height: 50,
                    width: 120,
                    child: DropdownButton(
                      isExpanded: true,
                      value: createWorkController.priorityValue,
                      items: [
                        ...priorityList.map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                      ],
                      onChanged: (value) {
                        if (value != null)
                          createWorkController.changePriorityValue(value);
                        setState(() {});
                      },
                    ),
                  )),
              DividerWorkItem(),
              ListTitleWork(
                Text('Cả ngày'),
                FontAwesomeIcons.stopwatch,
                Switch(
                  onChanged: (value) {
                    createWorkController.changeAllDaySwitch(value);
                    setState(() {});
                  },
                  value: createWorkController.allDaySwitch,
                  activeColor: createWorkController.colorIcon,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  children: [
                    ListTitleWork(
                        GestureDetector(
                          child:
                              Text(toDayString(createWorkController.startDate)),
                          onTap: () async {
                            await createWorkController.pickUpStartDate(context);
                            setState(() {});
                          },
                        ),
                        FontAwesomeIcons.arrowRight,
                        Visibility(
                          visible: !createWorkController.allDaySwitch,
                          child: GestureDetector(
                            child: Text(
                              toTimeString(createWorkController.startDate),
                              style: AppTextStyle.h2_5,
                            ),
                            onTap: () async {
                              await createWorkController
                                  .pickUpStartTime(context);
                              setState(() {});
                            },
                          ),
                        )),
                    ListTitleWork(
                        GestureDetector(
                          child:
                              Text(toDayString(createWorkController.endDate)),
                          onTap: () async {
                            await createWorkController.pickUpEndDate(context);
                            setState(() {});
                          },
                        ),
                        FontAwesomeIcons.arrowLeft,
                        Visibility(
                          visible: !createWorkController.allDaySwitch,
                          child: GestureDetector(
                            child: Text(
                              toTimeString(createWorkController.endDate),
                              style: AppTextStyle.h2_5,
                            ),
                            onTap: () async {
                              await createWorkController.pickUpEndTime(context);
                              setState(() {});
                            },
                          ),
                        )),
                  ],
                ),
              ),
              DividerWorkItem(),
              Container(
                child: Column(
                  children: [
                    ListTitleWork(
                      Text('Thiết lập nhắc nhở'),
                      Icons.message,
                      Switch(
                        onChanged: (value) {
                          createWorkController.changeReminderSwitch(value);
                          setState(() {});
                        },
                        value: createWorkController.reminderSwitch,
                        activeColor: createWorkController.colorIcon,
                      ),
                    ),
                    Builder(builder: (context) {
                      int max =
                          createWorkController.reminderTimeList.length + 1;
                      return Visibility(
                        visible: createWorkController.reminderSwitch,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: max,
                            itemBuilder: (context, index) {
                              if (index == max - 1)
                                return GestureDetector(
                                  child: ListTitleWork(Text('Thêm nhắc nhở'),
                                      FontAwesomeIcons.plus, null),
                                  onTap: () async {
                                    await createWorkController
                                        .insertReminderTime(context);
                                    setState(() {});
                                  },
                                );
                              return ListTitleWork(
                                  Text(createWorkController
                                      .reminderTimeList[index]),
                                  FontAwesomeIcons.clock,
                                  InkWell(
                                    child: Icon(FontAwesomeIcons.xmark),
                                    onTap: () {
                                      createWorkController
                                          .deleteReminderTime(index);
                                      setState(() {});
                                    },
                                  ));
                            },
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              DividerWorkItem(),
              ListTitleWork(
                Text('Lời nhắc báo thức'),
                Icons.alarm,
                Switch(
                  value: createWorkController.alarmSwitch,
                  onChanged: (value) {
                    createWorkController.changeAlarmSwitch(value);
                    setState(() {});
                  },
                  activeColor: createWorkController.colorIcon,
                ),
              ),
              DividerWorkItem(),
              //TODO
              Builder(
                builder: (context) {
                  if (createWorkController.loop != null) {
                    return Column(
                      children: [
                        ListTitleWork(
                            Text(createWorkController.contentRecurrence[0]),
                            Icons.repeat,
                            InkWell(
                              child: Icon(FontAwesomeIcons.xmark),
                              onTap: () {
                                createWorkController.removeLoop();
                                setState(() {});
                              },
                            )),
                        DividerWorkItem(),
                        ListTitleWork(
                            Text(createWorkController.contentRecurrence[1]),
                            FontAwesomeIcons.calendarXmark,
                            null),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      child: ListTitleWork(
                          Text('Không lặp lại'), Icons.repeat, null),
                      onTap: () async {
                        await createWorkController.openRecurringDialog(context);
                        setState(() {});
                      },
                    );
                  }
                },
              ),
              DividerWorkItem(),
              Container(
                child: Column(
                  children: [
                    ListTitleWork(Text('Màu sắc'), Icons.palette, null),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...colorList.map((e) => CustomColorRadio(index++, e))
                      ],
                    )
                  ],
                ),
              ),
              DividerWorkItem(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.location_on,
                        color: createWorkController.colorIcon,
                      ),
                      hintText: 'Vị trí'),
                ),
              ),
              DividerWorkItem(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.link,
                        color: createWorkController.colorIcon,
                      ),
                      hintText: 'URL'),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  String toDayString(DateTime? day) {
    return dayFormat.format(day!);
  }

  String toTimeString(DateTime? time) {
    return time24Format.format(time!);
  }

  Widget ListTitleWork(
      Widget contentWidget, IconData leadingIcon, Widget? trailingWidget) {
    return ListTile(
      title: contentWidget,
      leading: Icon(
        leadingIcon,
        color: createWorkController.colorIcon,
      ),
      trailing: trailingWidget,
    );
  }

  Widget CustomColorRadio(int index, Color color) {
    return OutlinedButton(
        onPressed: () {
          createWorkController.onChangedColorRadio(color);
          setState(() {});
        },
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(0),
            minimumSize: Size.fromRadius(14),
            side: BorderSide(
                width: 2,
                color: (createWorkController.colorIcon == color)
                    ? Colors.greenAccent
                    : Colors.transparent),
            shape: CircleBorder()),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45), color: color),
        ));
  }
}

class DividerWorkItem extends StatelessWidget {
  const DividerWorkItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.5,
      indent: 12,
      endIndent: 12,
    );
  }
}
