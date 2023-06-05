import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controllers/doctor/getQuizData.dart';
import '../../models/doctor_model.dart';

class PatientDetailedViewForDoc extends StatelessWidget {
  final PatientInfo patientInfo;
  PatientDetailedViewForDoc(this.patientInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    // chartData.addAll(
    //     get.map((e) => ChartData(e.createdAt, e.score)));
    GetQuizController getQuizController =
        Get.put(GetQuizController(patientInfo.patient!.uid.toString()));

    print(getQuizController.chartData);
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: getQuizController.isLoading.value,
        child: Scaffold(
          backgroundColor: const Color(0xff1A1B41),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    "Patient",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                  child: Material(
                    color: const Color(0xff1A1B41),
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 65,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patientInfo.patient!.name.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Obx(
                                      () => Text(
                                        'Recent score ${getQuizController.quiz.value.quizs.length != 0 ? getQuizController.quiz.value.quizs.last.score.toString() : '0'}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'Message Relative',
                                        style: TextStyle(
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    "Relative",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                patientInfo.relative != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 0),
                        child: Material(
                          color: const Color(0xff1A1B41),
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.black,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 65,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      patientInfo.relative?.first.name != null
                                          ? Text(
                                              patientInfo.relative?.first
                                                          .name !=
                                                      null
                                                  ? patientInfo
                                                      .relative!.first.name
                                                      .toString()
                                                  : '',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const Text(''),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                      // intervalType: DateTimeIntervalType.hours,
                      ),
                  series: <ChartSeries<ChartData, DateTime>>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: getQuizController.chartData,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.type);
  final DateTime x;
  final int? y;
  final type;
}
