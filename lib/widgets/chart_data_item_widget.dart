import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../styles.dart';
import '../themes.dart';

class BuildChartDataItemWidget extends StatefulWidget {
  BuildChartDataItemWidget({
    Key? key,
    required this.getController,
    required this.dataItemsName,
    required this.dataItemsValue,
    required this.max,
  }) : super(key: key);
  final getController;
  final dataItemsName;
  final dataItemsValue;

  var max;
  @override
  State<BuildChartDataItemWidget> createState() =>
      _BuildChartDataItemWidgetState();
}

class _BuildChartDataItemWidgetState extends State<BuildChartDataItemWidget> {
  @override
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  List<Color> colorss = [];
  @override
  void initState() {
    getData();
    _tooltip = TooltipBehavior(enable: false);
    setState(() {});
    super.initState();
  }

  getData() {
    setState(() {
      colorss.add(AppTheme.buttonColor);
      colorss.add(AppTheme.darkYellow);
      colorss.add(AppTheme.darkGreen);
      colorss.add(AppTheme.red);
      colorss.add(AppTheme.darkYellow);
      colorss.add(AppTheme.graphIronColor);
      colorss.add(AppTheme.darkYellow);
      colorss.add(AppTheme.red);
      colorss.add(AppTheme.buttonColor);
      colorss.add(AppTheme.darkYellow);
      colorss.add(AppTheme.darkGreen);
      colorss.add(AppTheme.red);
      colorss.add(AppTheme.darkYellow);
      colorss.add(AppTheme.graphIronColor);
      colorss.add(AppTheme.darkYellow);
      colorss.add(AppTheme.red);

      data = [
        for (int i = 0;
            i < widget.getController.metadata?.productMetadata!.length;
            i++) ...[
          _ChartData(
              widget.dataItemsName[i], widget.dataItemsValue[i], colorss[i])
        ]
      ];
    });
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height:
          widget.getController.metadata?.productMetadata!.length * Insets.xl,
      child: widget.getController.metadata != null
          ? SfCartesianChart(
              plotAreaBorderWidth: 0,
              enableAxisAnimation: true,
              margin: EdgeInsets.zero,
              primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines:
                      const MajorTickLines(color: Colors.transparent),
                  axisLine: AxisLine(
                      color: AppTheme.iconColor.withOpacity(0.5), width: 1),
                  labelStyle: TextStyles.title2.copyWith(
                      fontFamily: "proxima_nova_soft_regular", fontSize: 12)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}gm',
                  rangePadding: ChartRangePadding.additional,
                  minimum: -10,
                  maximum: widget.max + 300,
                  interval: 50,
                  isVisible: false),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<_ChartData, String>>[
                  BarSeries<_ChartData, String>(
                    dataSource: data,
                    spacing: 0.5,
                    isVisible: true,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyles.title2.copyWith(
                          fontFamily: "proxima_nova_soft_regular",
                          fontSize: 10),
                    ),
                    borderRadius: Corners.xlBorder,
                    pointColorMapper: (_ChartData data, _) => data.color,
                  )
                ])
          : SizedBox(),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color? color;
}
