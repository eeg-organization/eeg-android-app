import 'package:adv_eeg/controllers/relative/relativeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../doctorScreens/patientDetailedView(DocEnd).dart';
import '../landing.dart';

class RelativeSide extends StatelessWidget {
  RelativeSide({super.key});

  @override
  Widget build(BuildContext context) {
    RelativeController relativeController = Get.put(RelativeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Relative Side'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () {
                          GetStorage().erase();
                          Get.offAll(() => LandingPage());
                        },
                        child: Text('Yes'))
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Text(
                    'Patient ${relativeController.profile.value.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    "Quiz Scores:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                      // intervalType: DateTimeIntervalType.hours,
                      ),
                  series: <ChartSeries<ChartData, DateTime>>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: relativeController.chartData,
                      pointColorMapper: (ChartData data, _) =>
                          data.y! > 15 ? Colors.red : Colors.green,
                      name: 'Score',
                      onPointTap: (pointInteractionDetails) =>
                          print('${pointInteractionDetails.pointIndex}'),
                      xValueMapper: (ChartData data, _) => DateTime(
                          data.x.year, data.x.month, data.x.day, data.x.hour),
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      markerSettings: MarkerSettings(isVisible: true),
                      dataLabelMapper: (datum, index) =>
                          '${datum.type.toString()} , Score: ${datum.y.toString()}',
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    "EEG Scores:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                      // intervalType: DateTimeIntervalType.hours,
                      ),
                  series: <ChartSeries<ChartData, DateTime>>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: relativeController.brainScore,
                      pointColorMapper: (ChartData data, _) =>
                          data.y! >= 1 ? Colors.red : Colors.green,
                      name: 'Score',
                      onPointTap: (pointInteractionDetails) {
                        // Get.defaultDialog(
                        //   title:
                        //       pointInteractionDetails.dataPoints.toString(),
                        // );
                      },
                      xValueMapper: (ChartData data, _) => DateTime(
                          data.x.year, data.x.month, data.x.day, data.x.hour),
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      markerSettings: MarkerSettings(isVisible: true),
                      dataLabelMapper: (datum, index) =>
                          'Score: ${datum.y.toString()}',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
