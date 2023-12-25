// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
//
// class InvitationPage extends StatefulWidget {
//   const InvitationPage({super.key});
//
//   @override
//   _InvitationPageState createState() {
//     return _InvitationPageState();
//   }
// }
//
// enum InvitationSortMode {
//   seen,
//   unseen,
//   all
// }
//
// class _InvitationPageState extends State<InvitationPage> {
//   bool _isLoading = true;
//   InvitationSortMode _sortMode = InvitationSortMode.all;
//   final Map<InvitationSortMode, String> SortModeText = {
//     InvitationSortMode.all : 'Tất cả',
//     InvitationSortMode.seen : 'Đã xem',
//     InvitationSortMode.unseen : 'Chưa xem',
//   };
//   List<dynamic> _invitationSource = [1,2,3];
//
//   Future<void> _GetData() async {
//     // await something
//     _isLoading = false;
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _isLoading = true;
//     Future.delayed(Duration.zero, () {
//       this._GetData();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // TODO: implement Invitation card
//     List<Card> InvitationList = [];
//     _invitationSource.forEach((element) {
//       InvitationList.add(
//         Card(
//           color: Theme.of(context).colorScheme.surface,
//           child: InkWell(
//             onTap: () => {},
//             child: Container(
//               width: double.infinity,
//               height: 60,
//               margin: EdgeInsets.only(bottom: 4.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 10.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Nguoi moi
//                         RichText(
//                           text: TextSpan(
//                             text: 'Lời mời từ: ',
//                             style: AppTextStyle.h2_5.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: Theme.of(context).colorScheme.onBackground
//                             ),
//                             children: <TextSpan>[
//                               TextSpan(
//                                   text: '<example@gmail.com>',
//                                   style: TextStyle(
//                                       color: Theme.of(context).colorScheme.secondary
//                                   )
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Ngay moi
//                         RichText(
//                           text: TextSpan(
//                             text: 'Ngày: ',
//                             style: AppTextStyle.h3.copyWith(
//                                 fontWeight: FontWeight.normal,
//                                 color: Theme.of(context).colorScheme.onBackground
//                             ),
//                             children: <TextSpan>[
//                               TextSpan(
//                                   text: '<dd/MM/yyyy>',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Theme.of(context).colorScheme.tertiary
//                                   ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     )
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 10.0),
//                     child:
//                       Icon(
//                         Icons.close,
//                         color: Theme.of(context).colorScheme.error,
//                         size: 40,
//                       )
//                       /*
//                       switch(state){
//                         case InvitationState.accept:
//                           Icon(
//                             Icons.check,
//                             color: Theme.of(context).colorScheme.primary,
//                           )
//                           break;
//                         case InvitationState.decline:
//                           Icon(
//                             Icons.check,
//                             color: Theme.of(context).colorScheme.error,
//                           )
//                           break;
//                         default:
//                           null;
//                       }
//                       */
//                   )
//                 ],
//               )
//             )
//           )
//         )
//       );
//     });
//
//     // LOADING SCREEN
//     double loadingWidgetHeight =  max(640, MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2);
//     double loadingWidgetWidth = MediaQuery.of(context).size.width;
//     SizedBox loadingScreen = SizedBox(
//       width: loadingWidgetWidth,
//       height: loadingWidgetHeight,
//       child: Center(child: CircularProgressIndicator())
//     );
//
//     // TODO: implement Invitation Page
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lời mời',
//             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).colorScheme.primary
//             )
//         ),
//         actions: [
//           Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(SortModeText[_sortMode] ?? 'Tất cả',
//                     style: AppTextStyle.h2_5.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground
//                     ),
//                   ),
//                   PopupMenuButton(
//                     offset: Offset(0, 30),
//                     icon: Icon(
//                       Icons.more_vert,
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//                     itemBuilder: (context) {
//                       return [
//                         PopupMenuItem(
//                           child: Text('Tất cả'),
//                           value: InvitationSortMode.all,
//                           onTap: () async {
//                             _sortMode = InvitationSortMode.all;
//                             setState(() {});
//                           },
//                         ),
//                         PopupMenuItem(
//                           child: Text('Chưa xem'),
//                           value: InvitationSortMode.unseen,
//                           onTap: () async {
//                             _sortMode = InvitationSortMode.unseen;
//                             setState(() {});
//                           },
//                         ),
//                         PopupMenuItem(
//                           child: Text('Đã xem'),
//                           value: InvitationSortMode.seen,
//                           onTap: () async {
//                             _sortMode = InvitationSortMode.seen;
//                             setState(() {});
//                           },
//                         ),
//                       ];
//                     },
//                   )
//                 ],
//               )
//           )
//         ],
//       ),
//       body: _isLoading ? loadingScreen : Column(children: InvitationList),
//     );
//   }
// }
