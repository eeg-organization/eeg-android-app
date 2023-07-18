// ignore: file_names
import 'package:adv_eeg/models/profile_model.dart';
import 'package:adv_eeg/screens/doctorScreens/patientDetailedView(DocEnd).dart';
import 'package:adv_eeg/screens/patientScreens/quiz_page.dart';
import 'package:adv_eeg/utils/reportGenerator/quizReportGenerator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/doctor/doctorview_controller.dart';
import '../../controllers/doctor/getQuizData.dart';
import '../../controllers/patientSideControllers/getProfileController.dart';
import '../landing.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorViewController doctorViewController =
        Get.put(DoctorViewController());
    final GetProflieController getProfileController =
        Get.put(GetProflieController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1B41),
        elevation: 0,
        title: Text(
          'Doctor View',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                        onPressed: () async {
                          // await getProflieController.logout();
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
      backgroundColor: const Color(0xff1A1B41),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: doctorViewController.searchText,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Patient',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   'Severity',
                  //   style: GoogleFonts.poppins(
                  //     color: Colors.white,
                  //     fontSize: 15,
                  //     // fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: doctorViewController
                      .docDetails.value.data?.patientInfo!.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
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
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
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
                                      Obx(
                                        () => Text(
                                          '${doctorViewController.docDetails.value.data?.patientInfo![index].patient!.name}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {},
                                      //   child: const Text(
                                      //     'Message Relative',
                                      //     style: TextStyle(
                                      //         color: Colors.white,
                                      //         decoration:
                                      //             TextDecoration.underline),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    title: 'Patient Options',
                                    content: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Get.to(PatientDetailedViewForDoc(
                                              doctorViewController
                                                  .docDetails
                                                  .value
                                                  .data!
                                                  .patientInfo![index],
                                            ));
                                          },
                                          child: Text(
                                              'View Patient Previous Data'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.to(() => QuizPage(
                                                role: 'DOCTOR',
                                                uid: doctorViewController
                                                    .docDetails
                                                    .value
                                                    .data!
                                                    .patientInfo![index]
                                                    .patient!
                                                    .uid));
                                          },
                                          child:
                                              Text('Analyze Patient From Quiz'),
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              await getProfileController
                                                  .fetchQuiz(
                                                      doctorViewController
                                                          .docDetails
                                                          .value
                                                          .data!
                                                          .patientInfo![index]
                                                          .patient!
                                                          .uid!)
                                                  .then((value) async {
                                                await generateQuizReport(
                                                    getProfileController.quiz,
                                                    Profile(
                                                        name:
                                                            doctorViewController
                                                                .docDetails
                                                                .value
                                                                .data!
                                                                .patientInfo![
                                                                    index]
                                                                .patient!
                                                                .name,
                                                        uid:
                                                            doctorViewController
                                                                .docDetails
                                                                .value
                                                                .data!
                                                                .patientInfo![
                                                                    index]
                                                                .patient!
                                                                .uid!,
                                                        username:
                                                            doctorViewController
                                                                .docDetails
                                                                .value
                                                                .data!
                                                                .patientInfo![
                                                                    index]
                                                                .patient!
                                                                .username,
                                                        email:
                                                            doctorViewController
                                                                .docDetails
                                                                .value
                                                                .data!
                                                                .patientInfo![
                                                                    index]
                                                                .patient!
                                                                .email,
                                                        contact:
                                                            doctorViewController
                                                                .docDetails
                                                                .value
                                                                .data!
                                                                .patientInfo![
                                                                    index]
                                                                .patient!
                                                                .contact,
                                                        age:
                                                            doctorViewController
                                                                .docDetails
                                                                .value
                                                                .data!
                                                                .patientInfo![
                                                                    index]
                                                                .patient!
                                                                .age!));
                                              });
                                            },
                                            child: Text(
                                                'Download Patient Quiz Report'))
                                      ],
                                    ));
                                // Get.to(() => PatientDetailedViewForDoc(
                                //     doctorViewController.docDetails.value.data!
                                //         .patientInfo![index]));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.orange)),
                              child: const Text('View',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
