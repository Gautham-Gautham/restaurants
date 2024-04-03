import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_grandmerche/core/constants/colors/palletes.dart';
import 'package:the_grandmerche/core/constants/pictures/pictures.dart';
import 'package:the_grandmerche/features/home_screen/screen/home_screen.dart';
import 'package:the_grandmerche/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RegExp emailValidation = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$");
  bool check = false;
  final formkey = GlobalKey<FormState>();

  loginUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('login', true);
    pref.setString('username', emailController.text.trim());
    pref.setString('password', passwordController.text.trim()).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(width * .1),
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.75,
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Pictures.loginImage,
                          height: height * 0.3,
                          width: width,
                        ),
                        SizedBox(
                          height: width * .03,
                        ),
                        Text(
                          "Log In \nyour account",
                          style: TextStyle(
                              fontSize: width * .063,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (!emailValidation.hasMatch(value!)) {
                              return "Please enter valid email";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "User Name",
                            hintStyle: TextStyle(
                                fontSize: width * .04,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                borderSide:
                                    const BorderSide(color: Pallets.orange)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                borderSide:
                                    const BorderSide(color: Pallets.orange)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                borderSide:
                                    const BorderSide(color: Pallets.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                borderSide:
                                    const BorderSide(color: Pallets.orange)),
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (passwordController.text.trim().length < 8 ||
                                passwordController.text.trim() == '') {
                              return "Please Enter Password with 8 characters";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontSize: width * .04,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                borderSide:
                                    const BorderSide(color: Pallets.orange)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                borderSide:
                                    const BorderSide(color: Pallets.orange)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                borderSide:
                                    const BorderSide(color: Pallets.orange)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * .01)),
                                  side: BorderSide(width: width * 0.002),
                                  value: check,
                                  onChanged: (value) {
                                    setState(() {
                                      check = value!;
                                    });
                                  },
                                ),
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: width * .04,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: Pallets.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      loginUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width, width * 0.13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.03)),
                    backgroundColor: Pallets.orange,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
