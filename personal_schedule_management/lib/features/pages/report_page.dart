import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/config/theme/app_theme.dart';
import 'package:personal_schedule_management/features/controller/report_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/domain/entity/cong_viec_ht_entity.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() {
    return _ReportPageState();
  }
}

class _ReportPageState extends State<ReportPage> {
  ReportController reportController = ReportController();


  @override
  void initState() {
    super.initState();
  }

  DateTime monthOfYear = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: reportController.getAllNumberOfWorks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                int numOfFinish = reportController.numOfFinish;
                int numOfUnfinish = reportController.numOfUnFinish;
                int numOfLate = reportController.numOfLate;
                return Container(
                  margin: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          ReportBoxWidget(
                              'Số công việc hoàn thành', numOfFinish),
                          ReportBoxWidget(
                              'Số công việc chưa hoàn thành', numOfUnfinish),
                          ReportBoxWidget('Số công việc bị trễ', numOfLate),
                        ],
                      ),
                      SizedBox(
                          height: 400,
                          child: SplineChart(reportController.congViecHT)),
                      SizedBox(
                          height: 370,
                          child: numOfFinish != 0 ||
                                  numOfUnfinish != 0 ||
                                  numOfLate != 0
                              ? PieChart(numOfFinish, numOfUnfinish, numOfLate)
                              : Card(
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        'Tổng quan',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.h2.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            fontSize: 26),
                                      ),
                                    ),
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Theme.of(context).colorScheme.error,
                                          BlendMode.srcIn),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/image/no_chart.png'),
                                        width: 250,
                                        height: 250,
                                      ),
                                    ),
                                    Text(
                                      'Không có thông tin để hiển thị',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.h2_5.copyWith(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                    const SizedBox(height: 20)
                                  ],
                                ))),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class ReportBoxWidget extends StatelessWidget {
  String content;
  int quantity;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: 115,
      height: 120,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                content,
                style: AppTextStyle.normal.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            Spacer(),
            Text(
              '$quantity',
              style: AppTextStyle.h2
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }

  ReportBoxWidget(this.content, this.quantity, {super.key});
}

class SplineChart extends StatelessWidget {
  SplineChart(this.congViecHTList, {super.key});
  List<CongViecHT> congViecHTList;
  List<ChartData> completeData = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateFormat dateFormat = DateFormat('dd/MM');
    DateTime now = DateTime.now();
    Map<String, double> map = {
      '${dateFormat.format(now.subtract(Duration(days: 3)))}': 0,
      '${dateFormat.format(now.subtract(Duration(days: 2)))}': 0,
      '${dateFormat.format(now.subtract(Duration(days: 1)))}': 0,
      '${dateFormat.format(now.subtract(Duration(days: 0)))}': 0,
      '${dateFormat.format(now.add(Duration(days: 1)))}': 0,
      '${dateFormat.format(now.add(Duration(days: 2)))}': 0,
      '${dateFormat.format(now.add(Duration(days: 3)))}': 0,
    };
    congViecHTList.forEach((element) {
      String key = dateFormat.format(element.ngayHoanThanh);
      if (map.containsKey(key)) {
        map[key] = map[key]! + 1;
      }
    });
    completeData = [...map.keys.map((e) => ChartData(e, map[e]))];

    final TrackballBehavior _trackballBehavior = TrackballBehavior(
        enable: true,
        // Display mode of trackball tooltip
        activationMode: ActivationMode.singleTap);

    return Container(
      child: Card(
        child: SfCartesianChart(
            trackballBehavior: _trackballBehavior,
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(interval: 1),
            title: ChartTitle(
                text: 'Thống kê công việc hoàn thành trong 7 ngày',
                textStyle: AppTextStyle.h3),
            legend: Legend(
                isVisible: true,
                title: LegendTitle(
                    text: 'Chú thích',
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                orientation: LegendItemOrientation.auto),
            series: <ChartSeries>[
              // Renders spline chart
              SplineSeries<ChartData, String>(
                name: 'Công việc hoàn thành',
                legendIconType: LegendIconType.rectangle,
                dataSource: completeData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              ),
              /*SplineSeries<ChartData, int>(
                  name: 'Công việc chưa hoàn thành',
                  dataSource: chartData2,
                  legendIconType: LegendIconType.rectangle,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
              SplineSeries<ChartData, int>(
                  name: 'Công việc trễ',
                  dataSource: chartData3,
                  legendIconType: LegendIconType.rectangle,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),*/
            ]),
      ),
    );
  }
}

class PieChart extends StatefulWidget {
  PieChart(this.numofFinish, this.numOfUnfinish, this.numOfLate, {super.key});
  late int numofFinish;
  late int numOfUnfinish;
  late int numOfLate;

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late List<ChartData> chartData;

  @override
  void initState() {
    super.initState();
    chartData = [
      ChartData('Công việc hoàn thành', widget.numofFinish.toDouble()),
      ChartData('Công việc chưa hoàn thành', widget.numOfUnfinish.toDouble()),
      ChartData('Công việc trễ', widget.numOfLate.toDouble()),
    ];
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    int total = widget.numOfUnfinish + widget.numofFinish;
    return Card(
        child: SfCircularChart(
            title: ChartTitle(text: 'Tổng quan', textStyle: AppTextStyle.h2),
            legend: const Legend(
                isVisible: true,
                title: LegendTitle(
                    text: 'Chú thích',
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                orientation: LegendItemOrientation.auto,
                height: '200'),
            annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: Container(
                  child: Text('${widget.numofFinish + widget.numOfUnfinish}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20))))
        ],
            series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelMapper: (datum, index) =>
                  '${(datum.y! / total * 100).roundToDouble()}%',
              // Radius of doughnut
              radius: '110%',
              explode: true,
              explodeGesture: ActivationMode.singleTap,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  color: Theme.of(context).colorScheme.onBackground,
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 13)))
        ]));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final dynamic x;
  final double? y;
  late String _percent;

  String get percent => '$y%';
}
