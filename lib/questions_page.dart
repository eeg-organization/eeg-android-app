import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    int n = 6;
    int x = 4;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Colors.purple,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text('$x/$n'),
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Q-$x\) ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Question here........', //get question data from backend
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ToggleButtons(
                  direction: Axis.vertical,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  // selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.blue,
                  fillColor: Colors.blue,
                  // color: Colors.red[400],
                  constraints: BoxConstraints(
                    minHeight: 40.0,
                    minWidth: size.width * 0.8,
                  ),
                  onPressed: (int
                      index) {}, //implement onPressed for single or multiple choice questions ref:https://api.flutter.dev/flutter/material/ToggleButtons-class.html

                  isSelected: const [
                    true,
                    false
                  ],
                  children: const [
                    Padding(
                      //replace with list of options
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (x != 1)
                  Padding(
                    padding: EdgeInsets.all(16),
                    
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
                      onPressed: () {},
                      child: Text('Previous'),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xffFF7E1D))),
                    child: x!=n?Text('Save & Next'):Text('Submit'),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
