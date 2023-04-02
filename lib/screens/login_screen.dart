import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_65/main.dart';
import 'package:flutter_project_65/screens/create_account_screen.dart';
import 'package:flutter_project_65/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login to App"),
          backgroundColor: Color.fromARGB(255, 51, 196, 225), //เปลี่ยนสี AppBar
        ),
        body: Container(
          decoration: BoxDecoration(
            //เพิ่ม Background ให้กับหน้า Login
            image: DecorationImage(
              image: NetworkImage(
                "https://i.pinimg.com/originals/4f/53/00/4f53007e9bcb753c10b455f233d04c6b.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                SizedBox(height: 50), //เพิ่มระยะห่างข้างบน
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/3408/3408455.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email), //เพิ่ม icon ให้กับช่อง Email
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon:
                        Icon(Icons.lock), //เพิ่ม icon ให้กับช่อง Password
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //เปลี่ยนสีปุ่ม
                    primary: Colors.deepPurpleAccent,
                    textStyle:
                        TextStyle(color: Color.fromARGB(255, 100, 211, 64)),
                  ),
                  onPressed: () async {
                    bool res = await _service.login(
                        _emailController.text, _passwordController.text);
                    if (res) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Logged in")));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                title: 'Friend Address Information')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Invalid email or password. Please try again.")));
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountScreen()));
                  },
                  child: const Text(
                    "No Account? Create New Account.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
