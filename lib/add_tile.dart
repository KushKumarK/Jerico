import 'package:flutter/material.dart';


class AddControlPage extends StatelessWidget {
  const AddControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Control Tile"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 25.0
        ),
      ),
      backgroundColor: Colors.white,
      body: AddTileForm(),
    );
  }
}

class AddTileForm extends StatefulWidget {
  const AddTileForm({Key? key}) : super(key: key);

  @override
  State<AddTileForm> createState() => _AddTileFormState();
}

class _AddTileFormState extends State<AddTileForm> {
  String operation = " ";
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              elevation: 4.5,
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.text_fields, color: Colors.black,size: 30.0,),
                        SizedBox(width: 13.0,),
                        Expanded(
                            child:TextField(
                              onChanged: (text){
                                operation = text;
                              },
                          decoration: InputDecoration(
                            hintText: "Enter Operation Name",
                            hintStyle: TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.w200),
                          ),
                        ))
                      ],

            ))),
            SizedBox(height: 45.0 ,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 5.0,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )
              ),
                onPressed: (){
                Navigator.pop(context, operation);
                },
                child: Container(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ))
          ],
        ),
    ));
  }
}
