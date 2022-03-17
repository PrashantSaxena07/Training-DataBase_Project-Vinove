import 'package:aditya6015sqfliteproject/Screens/screen1.dart';
import 'package:aditya6015sqfliteproject/database/databse_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floating extends StatefulWidget {
  const Floating({Key? key}) : super(key: key);

  @override
  State<Floating> createState() => _FloatingState();
}

class _FloatingState extends State<Floating> {
  TextEditingController task = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController about = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent  ,
          title: Text("New Task"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Welcome(
                        title: '',
                      )));
            },
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Task Name",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.grey),
            ),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: TextField(

                controller: task,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'about task',
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Note",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.grey),
            ),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: about,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'about task',
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "date",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.grey),
            ),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: date,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'date',
                ),
              )),
          Center(
            child: ElevatedButton(
              child: Container(
                  height: 20,
                  width: 90.0,
                  child: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                  )),
              onPressed: () async {
                await DataBaseHelperClass.instance.insert(
                    {

                      DataBaseHelperClass.columnTitle: task.text,
                      DataBaseHelperClass.columnDate: date.text,
                      DataBaseHelperClass.columnNote: about.text

                    }
                );
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Welcome(title: '',)));
              },
            ),

          ),

        ]));
  }
}
