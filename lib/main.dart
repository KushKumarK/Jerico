import 'package:flutter/material.dart';
import 'package:home_voice/my_flutter_app_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

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
    "Remote Control"
  ];

  var _icons = [
    MyFlutterApp.tractor,
    FontAwesome.beaker,
    FontAwesome5.seedling,
    Icons.settings_remote
  ];



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add, color: Colors.black,),
          onPressed: (){},
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("Home Voice"),
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
        itemCount: _operations.length - 1,
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
                onPressed: (){},
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
}

