import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obsecure = true;

  void _login() {

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both email and password"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    postLogin();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Email: $email\nPassword: $password"),
        backgroundColor: Colors.green,
      ),
    );
  }



  Future postLogin() async {
    final response = await http.post(
        Uri.parse('https://api.sarbamfoods.com/accounts/login/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "email":_emailController.text.toString(),
          "password":_passwordController.text.toString(),
        }));


    return response;
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                Text(
                  "To the login screen",
                  style: TextStyle(fontSize: 20, color: Colors.grey.withOpacity(0.8)),
                ),
                const SizedBox(height: 100),
                TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.red,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "poppins",
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(fontFamily: "poppins",color: Colors.grey,fontSize: 14),
                    hintStyle: TextStyle(fontFamily: "poppins",color: Colors.grey,fontSize: 14),
                    hintText: 'Email of user',
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffcbcbcb), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Color(0xffcbcbcb), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    prefixIcon: Icon(Icons.email),
                  )
                ),
              const SizedBox(height: 20),
                TextFormField(
                  obscureText: _obsecure,
                  controller: _passwordController,
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.grey,fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffcbcbcb), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Color(0xffcbcbcb), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: GestureDetector(
                          onTap: (){
                            if(_obsecure==true){
                              setState(() {
                                _obsecure=false;
                              });
                            }else{
                             setState(() {
                               _obsecure=true;
                             });
                            }
                          },
                          child: Icon(_obsecure?Icons.remove_red_eye:Icons.remove_red_eye_outlined)),
                    ),

                ),
                const SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
