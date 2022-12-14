import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_voice/my_flutter_app_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'add_tile.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "HomeVoice",
      debugShowCheckedModeBanner: false,
      home: HomePageView(),
    );
  }
}


class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);


  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  List<String> _operations = [
    "LIFO",
    "Irrigation",
    "Fertilizer",
    "Plant Seed",
    "Remote Control",
    "Stop Machine"
  ];
  var response;
  var _icons = [
    MyFlutterApp.tractor,
    Icons.water_drop,
    FontAwesome.beaker,
    FontAwesome5.seedling,
    Icons.settings_remote,
    Icons.highlight_off,
  ];

  void addToLists(String opName){
    _operations.add(opName);
    _icons.add(Icons.circle_outlined);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add, color: Colors.black,),
          onPressed: (){
            _getDataFromAdd(context);
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("Jerico - For B.A.R.F"),
        titleTextStyle: const TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            color: Colors.black,
          fontSize: 25.0
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: false,
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(12.0),
        itemCount: _operations.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 20.0,
          ),
        itemBuilder: (BuildContext context, int index) {
            return Container(
                child: SizedBox(
              height: 200,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  primary: Colors.white,
                  shadowColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),

                  )
                ),
                onPressed: (){
                  sendData(_operations[index]);

                },
                onLongPress: (){
                  if (index <6) {
                    _notApplicableDialog(index);
                  } else {
                    _showDeleteDialog(index);
                  }},
                child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_icons[index], color: Colors.black,),
                          SizedBox(height: 18,),
                          Text(
                              _operations[index],
                            style: TextStyle(
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                  ),
                )),
              ),
            ));
        }),
      ));
  }

  Future _getDataFromAdd(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddControlPage())
    );

    if (!mounted) return;
    setState(() {
      _operations.add(result);
      _icons.add(Icons.circle_outlined);
    });

  }
  Future<void> _showDeleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do You want to Delete this Action?', style: TextStyle(fontFamily: "QuickSand"),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('YES', style: TextStyle(color: Colors.black, fontFamily: "Quicksand"),),
              onPressed: () {
                sendDeleteData(index);
                _operations.removeAt(index);
                _icons.removeAt(index);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _notApplicableDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a fixed Feature and cannot be deleted.',
                  style: TextStyle(
                      fontFamily: "QuickSand",
                    fontWeight: FontWeight.w300,
                  ),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Quicksand",
                fontWeight: FontWeight.bold
              ),),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _ResponseDialog(String response) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text( response,
                  style: TextStyle(
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.w300,
                  ),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold
              ),),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
  Future<http.Response> sendData(String action) async {
    final response = await http.post(
      Uri.parse("http://192.168.29.229:8000/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'String'
      },
      body: jsonEncode(<String,String>{
        "action": action
      }),
    );
    if(response.statusCode == 200){
      _ResponseDialog(response.body);
    } else {
      _ResponseDialog("Could not send Data to B.A.R.F");
    }
    return response;

  }
  Future<http.Response> sendDeleteData(int index) async {
    final response = await http.post(
      Uri.parse("http://192.168.29.229:8000/delete_tile"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'String'
      },
      body: jsonEncode(<String,String>{
        "action": _operations[index],
        "index":index.toString()
      }),
    );
    if(response.statusCode == 200){
      _ResponseDialog(response.body);
    } else {
      _ResponseDialog("Deleted Successfully");
    }
    return response;

  }
}
