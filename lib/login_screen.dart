// ignore_for_file: unused_local_variable, avoid_print, unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedbackdashboard/color_manager.dart';
import 'package:feedbackdashboard/dashboard.dart';
import 'package:feedbackdashboard/font_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.clear();
    _passwordController.clear();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Container(
          height: 320,
          width: 400,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),

                spreadRadius: 0.5,
                blurRadius: 4,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            // border: Border.all(color: ColorManager.darkBlack, width: 2),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Admin Login",
                style: TextStyle(
                  color: ColorManager.darkBlack,
                  // fontFamily: FontConstants.fontFamily,
                  fontWeight: FontWeightManager.semibold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 4, 15, 0),
                child: SizedBox(
                  height: 60,
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    expands: false,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.2,
                          color: ColorManager.darkBlack,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: ColorManager.mediumBlack,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'email',
                      hintStyle: TextStyle(
                        color: ColorManager.lightBlack,
                      ),
                      focusColor: ColorManager.secondary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 4, 15, 0),
                child: SizedBox(
                  height: 60,
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    expands: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.2,
                          color: ColorManager.darkBlack,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: ColorManager.mediumBlack,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'password',
                      hintStyle: TextStyle(
                        color: ColorManager.lightBlack,
                      ),
                      focusColor: ColorManager.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    //border: Border.all(color: ColorManager.darkBlack, width: 2),
                    color: ColorManager.skyBlue,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      loginUser();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        //  fontFamily: FontConstants.fontFamily,
                        fontWeight: FontWeightManager.semibold,
                        fontSize: 22,
                        color: ColorManager.darkBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    List allDataComplains = [];
    List allDataFeedback = [];
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    print(res);
    if (res == "success") {
      await FirebaseFirestore.instance
          .collection('Complains')
          .get()
          .then((QuerySnapshot querySnapshot) {
        // ignore: avoid_function_literals_in_foreach_calls
        querySnapshot.docs.forEach((doc) {
          allDataComplains.add([
            doc['title'], //0
            doc['name'], //1
            doc['phone'], //2
            doc['address'], //3
            doc['ward'], //4
            doc['message'], //5
            doc['dateTime'], //6
            doc['isMedia'], //7
            doc['imageUrl'], //8
            doc['comPostId'] //9
          ]);
        });
      });

      await FirebaseFirestore.instance
          .collection('Feedback')
          .get()
          .then((QuerySnapshot querySnapshot) {
        // ignore: avoid_function_literals_in_foreach_calls
        querySnapshot.docs.forEach((doc) {
          allDataFeedback.add([
            doc['name'],
            doc['message'],
            // doc['dateTime'],
            //doc['comFeedId']
          ]);
        });
      });
       // ignore: use_build_context_synchronously
      showSnackBar(context, 'Login Success', true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => DashboardScreen(
                allDataFeedback: allDataFeedback,
                allDataComplains: allDataComplains)),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Incorrect Credentials', false);
    }
  }
}

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Something Happened";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Enter in all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

showSnackBar(
  BuildContext context,
  String content,
  bool type,
) {
  final snackBar = SnackBar(
    backgroundColor: ColorManager.transparent,
    padding: const EdgeInsets.all(10),
    content: Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
        color: ColorManager.skyBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        type
            ? Icon(
                Icons.done,
                color: ColorManager.white,
              )
            : Icon(
                Icons.error,
                color: ColorManager.white,
              ),
        const SizedBox(
          width: 20,
        ),
        Text(
          content,
          style: TextStyle(
            fontWeight: FontWeightManager.medium,
            fontSize: 16,
            color: ColorManager.white,
          ),
        ),
      ]),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
