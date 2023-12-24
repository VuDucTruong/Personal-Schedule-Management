import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/features/controller/invitation_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/entity/thu_moi_entity.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({super.key});

  @override
  _InvitationPageState createState() {
    return _InvitationPageState();
  }
}

enum InvitationSortMode { seen, unseen, all }

class _InvitationPageState extends State<InvitationPage> {
  InvitationSortMode _sortMode = InvitationSortMode.all;
  final Map<InvitationSortMode, String> SortModeText = {
    InvitationSortMode.all: 'Tất cả',
    InvitationSortMode.seen: 'Đã xem',
    InvitationSortMode.unseen: 'Chưa xem',
  };
  late DateFormat dayFormat;
  late Future<void> _getData;
  InvitationController invitationController = InvitationController();
  @override
  void initState() {
    super.initState();

    _getData = invitationController.getInvitationList();
  }

  Future<void> setUpData() async {
    await invitationController.getInvitationList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dayFormatString =
        prefs.getString(DATE_FORMAT) ?? AppDateFormat.DAY_MONTH_YEAR;
    dayFormat = DateFormat(dayFormatString, 'vi_VN');
  }

  @override
  Widget build(BuildContext context) {
    // LOADING SCREEN
    // TODO: implement Invitation Page
    return Scaffold(
        appBar: AppBar(
          title: Text('Danh sách lời mời',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
          actions: [
            Row(
              children: [
                PopupMenuButton(
                  offset: Offset(0, 30),
                  icon: Icon(
                    Icons.filter_alt_rounded,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Tất cả'),
                        value: InvitationSortMode.all,
                        onTap: () async {
                          _sortMode = InvitationSortMode.all;
                          setState(() {});
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Chưa xem'),
                        value: InvitationSortMode.unseen,
                        onTap: () async {
                          _sortMode = InvitationSortMode.unseen;
                          setState(() {});
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Đã xem'),
                        value: InvitationSortMode.seen,
                        onTap: () async {
                          _sortMode = InvitationSortMode.seen;
                          setState(() {});
                        },
                      ),
                    ];
                  },
                ),
                Text(
                  SortModeText[_sortMode] ?? 'Tất cả',
                  style: AppTextStyle.h2_5.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
        body: FutureBuilder(
          future: _getData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: invitationController.thuMoiList.length,
                itemBuilder: (context, index) {
                  return InvitationItem(
                    invitationController.thuMoiList[index],
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget InvitationItem(ThuMoi thuMoi) {
    return Card(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
            onTap: () => {},
            child: Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.only(bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nguoi moi
                            RichText(
                              text: TextSpan(
                                text: 'Lời mời từ: ',
                                style: AppTextStyle.h2_5.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: thuMoi.emailNM,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                            ),
                            // Ngay moi
                            RichText(
                              text: TextSpan(
                                text: 'Ngày: ',
                                style: AppTextStyle.h3.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: dayFormat.format(thuMoi.ngayGui),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    InkWell(
                      child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).colorScheme.error,
                            size: 40,
                          )),
                      onTap: () {
                        invitationController.deleteInvitation(thuMoi.maTM);
                        setState(() {
                          invitationController.thuMoiList.remove(thuMoi);
                        });
                      },
                    )
                  ],
                ))));
  }
}
