import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:step_progress_indicator/step_progress_indicator.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key, required this.type}) : super(key: key);
  final type;
  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

int? n = 0;
int x = 0;
int score = -1;
var init;
var options = [];
List questions = [];
List descriptions = [];

List trueFalse = [];
bool loading = true;

class _QuestionsPageState extends State<QuestionsPage> {
  Future getQuestions() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final url =
        'https://clairvoyant.up.railway.app/api/v1/get-questionare/?type=${widget.type}';
    try {
      var resp = await http.get(Uri.parse(url), headers: header);
      var body = jsonDecode(resp.body);
      setState(() {
        init = body['questions'];
        // val=questions.length;
        n = init.length;
        init.forEach((ele) {
          Map obj = ele;
          // obj['question'].forEach((element){
          //   // print(element['question']);
          //   // quests.add(element['question']);
          //
          //   // descriptions.add(element['description'].toString());
          // });
          questions.add(obj['question']['question'].toString());
          descriptions.add(obj['question']['description'].toString());
          // print(opts);
          // Map opti=obj['option'];
          var sampOpts = [];
          var sampTF = [];
          obj['options'].forEach((element) {
            Map o = element;

            // print(o['option']);
            setState(() {
              sampOpts.add(o['option']);
              sampTF.add(false);
            });
            // print(sampOpts);
          });
          // print(sampOpts);
          trueFalse.add(sampTF);
          options.add(sampOpts);
          // sampOpts=[];
        });

        loading = false;

        // options.fillRange(0, questions.length,[false,false,false,false]);
      });

      // print(options);
      // print(questions.length);
      // print(jsonDecode(resp.body));
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    options = [];
    descriptions = [];
    questions = [];
    getQuestions();

    trueFalse = [];
    loading = true;

    x = 0;
    n = 0;
  }

  // Future setOptions() async {
  //   await getQuestions().whenComplete(() {
  //     print(n);
  //     if(n!=0) {
  //
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(color: Colors.black)
                  // ],
                  // backgroundBlendMode: BlendMode.color,
                  image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.softLight),
                      image: AssetImage('assets/bg1.jpg'),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    loading
                        ? const Text('')
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: n != null || n != 0
                                ? StepProgressIndicator(
                                    totalSteps: n!,
                                    currentStep: x + 1,
                                    selectedColor: Colors.purple,
                                  )
                                : null,
                          ),
                    if (n != null || n != 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '${x + 1}/$n',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: descriptions[x] != "null"
                          ? Row(
                              children: [
                                Text(
                                  questions[x], //get question data from backend
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  message: descriptions[x],
                                  child: const Icon(
                                    Icons.info,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          : const SizedBox(),
                    ),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    loading
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SizedBox(
                              height: size.height * 0.5,
                              child: ListView.builder(
                                itemCount: trueFalse[x].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        score = index;
                                        trueFalse[x][index] =
                                            !trueFalse[x][index];
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              side: const BorderSide(
                                                  color: Colors.white)),
                                          color: trueFalse[x][index]
                                              ? Colors.blue
                                              : Colors.transparent,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 4),
                                            child: Text(
                                              options[x][index],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ))),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    // SizedBox(
                    //   height: size.height * 0.05,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (x != 0)
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black)),
                              onPressed: () {
                                setState(() {
                                  x--;
                                });
                              },
                              child: const Text('Previous'),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //for save button
                                if (x != n! - 1) {
                                  x++;
                                  // print(x);
                                }
                              });
                            },
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xffFF7E1D))),
                            child: x != n! - 1
                                ? const Text('Save & Next')
                                : const Text('Submit'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
    );
  }
}
