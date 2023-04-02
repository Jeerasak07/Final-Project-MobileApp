import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_project_65/screens/login_screen.dart';
import 'package:flutter_project_65/services/auth_service.dart';

class CreateAccountScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new Account"),
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
                    "https://cdn-icons-png.flaticon.com/512/9068/9068651.png"),
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
                  suffixIcon: Icon(Icons.lock), //เพิ่ม icon ให้กับช่อง Password
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  suffixIcon:
                      Icon(Icons.lock), //เพิ่ม icon ให้กับช่อง Confirm Password
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please Enter Email or Password")));
                  } else {
                    bool res = await _service.register(
                        _emailController.text, _passwordController.text);
                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Account Created")));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  }
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text(
                  "Already have an account? Log in here.",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
