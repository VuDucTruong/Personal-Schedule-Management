import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/widgets/stateless/works_list_item_widget.dart';

class Works {
  final String name;
  final String creator;

  Works({required this.name, required this.creator});
}

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  String selectedCategory = 'Tất cả';
  bool isTruocExpanded = false;
  bool isTuongLaiExpanded = false;
  bool isTodayExpanded = false;
  Offset _position = Offset(150, 300);
  final List<Works> WorksItemList = [
    Works(name: 'Mục 1', creator: 'Người tạo 1'),
    Works(name: 'Mục 2', creator: 'Người tạo 2'),
    Works(name: 'Mục 3', creator: 'Người tạo 3'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Lấy kích thước màn hình
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      // Đặt vị trí ban đầu ở góc dưới bên phải
      setState(() {
        _position = Offset(screenWidth - 90, screenHeight - 180);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: (size.width - 108) / 3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: selectedCategory == 'Tất cả'
                                ? lightColorScheme.primaryContainer
                                : lightColorScheme.secondaryContainer,
                          ),
                          child: Text(
                            'Tất cả',
                            style: AppTextStyle.h3.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedCategory =
                                'Tất cả'; // Cập nhật biến khi được chọn
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          height: 35,
                          alignment: Alignment.center,
                          width: (size.width - 108) / 3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: selectedCategory == 'Công việc'
                                ? lightColorScheme.primaryContainer
                                : lightColorScheme.secondaryContainer,
                          ),
                          child: Text(
                            'Công việc',
                            style: AppTextStyle.h3.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Công việc';
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          height: 35,
                          alignment: Alignment.center,
                          width: (size.width - 108) / 3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: selectedCategory == 'Cá nhân'
                                ? lightColorScheme.primaryContainer
                                : lightColorScheme.secondaryContainer,
                          ),
                          child: Text(
                            'Cá nhân',
                            style: AppTextStyle.h3.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Cá nhân';
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 30,
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton<String>(
                          offset: Offset(0, 48),
                          padding: const EdgeInsets.all(0),
                          icon: Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'mana') {
                            } else if (value == 'search') {
                            } else if (value == 'sort') {
                            } else if (value == 'in') {}
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'mana',
                              child: Text('Quản lý Danh mục'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'search',
                              child: Text('Tìm kiếm'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'sort',
                              child: Text('Sắp xếp công việc'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'in',
                              child: Text('In'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isTruocExpanded = !isTruocExpanded;
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Trước',
                                style: AppTextStyle.h3.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              Icon(isTruocExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      if (isTruocExpanded)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: WorksItemList.length,
                          itemBuilder: (context, index) {
                            final work = WorksItemList[index];
                            return WorksListItem(
                              name: work.name,
                              creator: work.creator,
                            );
                          },
                        ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isTodayExpanded = !isTodayExpanded;
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Hôm nay',
                                style: AppTextStyle.h3.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              Icon(isTodayExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      if (isTodayExpanded)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: WorksItemList.length,
                          itemBuilder: (context, index) {
                            final work = WorksItemList[index];
                            return WorksListItem(
                              name: work.name,
                              creator: work.creator,
                            );
                          },
                        ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isTuongLaiExpanded = !isTuongLaiExpanded;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Tương lai',
                              style: AppTextStyle.h3.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Icon(isTuongLaiExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      if (isTuongLaiExpanded)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: WorksItemList.length,
                          itemBuilder: (context, index) {
                            final work = WorksItemList[index];
                            return WorksListItem(
                              name: work.name,
                              creator: work.creator,
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              child: FloatingActionButton(
                backgroundColor: lightColorScheme.primaryContainer,
                onPressed: () {
                  // Xử lý khi nút được bấm
                },
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 30,
                  color: Colors.white,
                ),
                shape: CircleBorder(),
              ),
              feedback: FloatingActionButton(
                backgroundColor: lightColorScheme.primaryContainer,
                onPressed: () {},
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 30,
                  color: Colors.white,
                ),
                shape: CircleBorder(),
              ),
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  _position = offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
