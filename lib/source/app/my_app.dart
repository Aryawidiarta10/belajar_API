import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/source/ui/formAdd/form_add_screen.dart';
import 'package:flutter_crud_api_sample_app/source/ui/home/home_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          leading: Icon(
            Icons.home,
            color: Colors.green[800],
            size: 30
          ),
          title: Text(
            "ANGGOTA PTI 4 D",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FormAddScreen();
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.green[800],
                  size: 30
                ),
              ),
            ),
          ],
        ),
        body: HomeScreen(),
      ),
    );
  }
}