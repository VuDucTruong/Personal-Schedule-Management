import 'package:flutter/material.dart';
import 'package:personal_schedule_management/config/text_styles/app_text_style.dart';
import 'package:personal_schedule_management/features/widgets/stateful/month_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() {
    return _ReportPageState();
  }
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime monthOfYear = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(4),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MonthWidget(monthOfYear),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReportBoxWidget('Số công việc hoàn thành', 20),
                  ReportBoxWidget('Số công việc chưa hoàn thành', 20),
                  ReportBoxWidget('Số công việc bị trễ', 20),
                ],
              ),
              SizedBox(height: 400, child: SplineChart()),
              SizedBox(
                height: 350,
                child: PieChart(),
              ),
              Card(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                          'Công việc đang tiến hành',
                          style: AppTextStyle.h2,
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const Column(
                          children: [
                            ListTile(
                              title: Text('Title'),
                              trailing: SizedBox(
                                width: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '1',
                                      style: AppTextStyle.h3,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                              indent: 4,
                              endIndent: 4,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
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
                style: AppTextStyle.normal,
              ),
            ),
            Spacer(),
            Text(
              '$quantity',
              style: AppTextStyle.h2,
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
  SplineChart({super.key});
  final List<ChartData> chartData1 = [
    ChartData(2010, 35),
    ChartData(2011, 13),
    ChartData(2012, 34),
    ChartData(2013, 27),
    ChartData(2014, 40)
  ];
  final List<ChartData> chartData3 = [
    ChartData(2010, 20),
    ChartData(2011, 13),
    ChartData(2012, 1),
    ChartData(2013, 13),
    ChartData(2014, 54)
  ];
  final List<ChartData> chartData2 = [
    ChartData(2010, 3),
    ChartData(2011, 1),
    ChartData(2012, 34),
    ChartData(2013, 20),
    ChartData(2014, 19)
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final TrackballBehavior _trackballBehavior = TrackballBehavior(
        enable: true,
        // Display mode of trackball tooltip
        activationMode: ActivationMode.singleTap);

    return Container(
      child: Card(
        child: SfCartesianChart(
            trackballBehavior: _trackballBehavior,
            primaryXAxis: NumericAxis(),
            title: ChartTitle(
                text: 'Thống kê công việc theo tháng',
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
              SplineSeries<ChartData, int>(
                name: 'Công việc hoàn thành',
                legendIconType: LegendIconType.rectangle,
                dataSource: chartData1,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              ),
              SplineSeries<ChartData, int>(
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
                  yValueMapper: (ChartData data, _) => data.y),
            ]),
      ),
    );
  }
}

class PieChart extends StatelessWidget {
  PieChart({super.key});

  final List<ChartData> chartData = [
    ChartData('Công việc hoàn thành', 25),
    ChartData('Công việc chưa hoàn thành', 38),
    ChartData('Công việc trễ', 34),
  ];

  Widget build(BuildContext context) {
    // TODO: implement build
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
                  child: const Text('40',
                      style: TextStyle(color: Colors.black, fontSize: 20))))
        ],
            series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelMapper: (datum, index) => datum.percent,
              // Radius of doughnut
              radius: '110%',
              explode: true,
              explodeGesture: ActivationMode.singleTap,
              dataLabelSettings: DataLabelSettings(isVisible: true))
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
