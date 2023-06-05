import 'package:adv_eeg/screens/yogaPoseDetailed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/yogaController.dart';
import '../models/yogaModel.dart';

class YogaScreen extends StatelessWidget {
  final YogaController controller = Get.put(YogaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yoga for Depression'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.yogaPoses.length,
          itemBuilder: (context, index) {
            return YogaPoseCard(
              yogaPose: controller.yogaPoses[index],
            );
          },
        ),
      ),
    );
  }
}

class YogaPoseCard extends StatelessWidget {
  final YogaPose yogaPose;

  const YogaPoseCard({
    required this.yogaPose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => YogaPoseDetailScreen(yogaPose: yogaPose));
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32.0,
                backgroundImage: NetworkImage(yogaPose.poseImage),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      yogaPose.poseName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      yogaPose.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
