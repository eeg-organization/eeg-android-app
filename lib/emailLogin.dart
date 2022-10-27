import 'package:flutter/material.dart';
class EmailLogin extends StatefulWidget {
  // const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/bg1.jpg',),fit: BoxFit.cover)),
        child: SafeArea(child: Column(
          children: [
            SizedBox(height: size.height*0.15,),
            const Align(alignment: Alignment.topCenter,child: Text('Login with your E-mail',style: TextStyle(fontSize: 30),),),
            SizedBox(height:size.height*0.05 ,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: Text('Email',style: TextStyle(fontSize: 30),),),
            ),
            Material(
              // elevation: 20,
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  obscureText: true,

                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),

                      //   hintStyle: TextStyle(color:Colors.black),
                      hintText: 'Enter your Email',
                      // icon: Icon(Icons.lock)
                  ),
                  style: const TextStyle(
                    // color:Colors.white
                  ),
                ),
              ),
            ),SizedBox(height:size.height*0.05 ,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(alignment: Alignment.topLeft,child: Text('Password',style: TextStyle(fontSize: 30),),),
            ),
            Material(
              // elevation: 20,
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  obscureText: true,

                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),

                      //   hintStyle: TextStyle(color:Colors.black),
                      hintText: 'Enter your password',
                      // icon: Icon(Icons.lock)
                  ),
                  style: const TextStyle(
                    // color:Colors.white
                  ),
                ),
              ),
            ),
            Align(alignment: Alignment.topRight,child: TextButton(onPressed: (){}, child: const Text('Forgot Password?',style: TextStyle(decoration: TextDecoration.underline),)))
            ,SizedBox(height: size.height*0.05,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50))),
                    child: const Text('Login')))),
            Align(alignment: Alignment.topCenter,child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              const Text('New User?',style: TextStyle(color: Colors.black38)),TextButton(onPressed: (){}, child: const Text('Sign up'))
            ],),)

          ],
        ),),
      ),
    );
  }
}
