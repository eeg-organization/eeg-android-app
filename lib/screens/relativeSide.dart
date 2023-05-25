import 'package:adv_eeg/screens/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';

class RelativeSide extends StatelessWidget {
  const RelativeSide({super.key});

  @override
  Widget build(BuildContext context) {
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
                          GetStorage().remove('loginDetails');
                          Get.offAllNamed('/');
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
      body: const Placeholder(),
    );
  }
}
