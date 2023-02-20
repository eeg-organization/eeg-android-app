import 'package:adv_eeg/controllers/getAllUsers.dart';
import 'package:adv_eeg/screens/patient_login.dart';
import 'package:adv_eeg/screens/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AdminMain extends StatefulWidget {
  AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: const Text('Admin'),
        bottom: TabBar(controller: controller, tabs: [
          Tab(
            child: Text('All Users'),
          ),
          Tab(
            child: Text('All Doctors'),
          ),
          Tab(
            child: Text('All Relatives'),
          ),
        ]),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //   Colors.black87,
            //   BlendMode.hardLight,
            // ),
          ),
        ),
        child: TabBarView(
          controller: controller,
          children: [
            AllUsers(),
            AllDoctors(),
            AllRelatives(),
            // const Placeholder(),
          ],
        ),
      ),
    );
  }
}

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController usersController = Get.put(UsersController('USER'));
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: usersController.isLoading.value,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpPage(role: 'USER'));
                  },
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add)),
                        const Text('Add Patient'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: usersController.users.value.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          enableFeedback: true,
                          title: Obx(
                            () => Text(
                                '${usersController.users.value.data?[index].name}'),
                          ),
                          trailing: Icon(Icons.forward),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AllDoctors extends StatelessWidget {
  const AllDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController usersController = Get.put(UsersController('DOCTOR'));
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: usersController.isLoading.value,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpPage(role: 'DOCTOR'));
                  },
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add)),
                        const Text('Add Doctor'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount:
                          usersController.doctors.value.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          enableFeedback: true,
                          title: Obx(
                            () => Text(
                                '${usersController.doctors.value.data?[index].name}'),
                          ),
                          trailing: Icon(Icons.forward),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AllRelatives extends StatelessWidget {
  const AllRelatives({super.key});

  @override
  Widget build(BuildContext context) {
    UsersController usersController = Get.put(UsersController('RELATIVE'));
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: usersController.isLoading.value,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpPage(role: 'RELATIVE'));
                  },
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.white,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add)),
                        const Text('Add Relative'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount:
                          usersController.relatives.value.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          enableFeedback: true,
                          title: Obx(
                            () => Text(
                                '${usersController.relatives.value.data?[index].name}'),
                          ),
                          trailing: Icon(Icons.forward),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
