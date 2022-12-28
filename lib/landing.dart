import 'dart:convert';

import 'package:adv_egg/emailLogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hi there 👋',
                    style: TextStyle(fontSize: 30
                        // fontSize: size.width*0.5
                        ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''Welcome''',
                    style: TextStyle(fontSize: 45
                        // fontSize: size.width*0.5
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text('Login as User'), Text('-->')],
                        ))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: >)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const EmailLogin()));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Login as Doctor'),
                            Text('-->')
                          ],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Login as Relative'),
                            Text('-->')
                          ],
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
