import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_65/screens/edit_item_screen.dart';
import 'package:flutter_project_65/screens/login_screen.dart';
import 'package:flutter_project_65/screens/new_item_screen.dart';
import 'package:flutter_project_65/services/auth_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); //เริ่มการทำงานของแอปพลิเคชัน
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 51, 196, 225),
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    User? currentUser = _service.user;
    String displayEmail = "";
    if (currentUser != null && currentUser.email != null) {
      displayEmail = currentUser.email!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: Theme.of(context).textTheme.headline1),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Color.fromARGB(255, 92, 231, 222),
              height: 100.0,
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 70.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Hello, $displayEmail",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.greenAccent,
                size: 30,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                _service.logout(currentUser);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.face_retouching_natural_outlined,
                    color: Colors.black12),
                title: Text(dataDocuments[index]["name"].toString()),
                subtitle: Text(dataDocuments[index]["desc"].toString()),
                onTap: () => _editItemScreen(dataDocuments[index].id,
                    dataDocuments[index]["name"], dataDocuments[index]["desc"]),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'New Item',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //การสร้าง method _createNewItem() สำหรับการเพิ่มข้อมูลใหม่ในหน้า MyHomePage
  void _createNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewItemScreen()));
  }

  //สร้าง method _editItemScreen() สำหรับการแก้ไขข้อมูลที่เลือกแสดงในหน้าแอปพลิเคชัน
  _editItemScreen(String documentid, String itemName, String itemDesc) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditItemScreen(documentid, itemName, itemDesc)));
  }
}
