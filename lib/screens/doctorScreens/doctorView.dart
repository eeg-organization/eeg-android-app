// ignore: file_names
import 'package:adv_eeg/screens/doctorScreens/patientDetailedView(DocEnd).dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/doctor/doctorview_controller.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorViewController doctorViewController =
        Get.put(DoctorViewController());

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
              GetStorage().erase();
              Get.offAllNamed('/');
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
                  Row(
                    children: [
                      Text(
                        'Severity',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // DropdownButton(
                      //   onChanged: (value) =>
                      //       doctorViewController.droopDownController,
                      //   items: [
                      //     DropdownMenuItem(child: Text('High')),
                      //     DropdownMenuItem(child: Text('Medium')),
                      //     // DropdownMenuItem(child: Text('Low')),
                      //     // DropdownMenuItem(child: Text('High')),
                      //   ],
                      // )
                    ],
                  ),
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
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => PatientDetailedViewForDoc(
                                    doctorViewController.docDetails.value.data!
                                        .patientInfo![index]));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.orange)),
                              child: const Text('View'),
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
