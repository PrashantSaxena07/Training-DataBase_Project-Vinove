import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'databse.dart';
import 'mainscreen.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController task = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController about = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("New Task"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(
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
                  color: Colors.blueAccent),
            ),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: task,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mention The Name of The Task',
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Note",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueAccent),
            ),
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: about,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tell Something About The Task',
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Don't Forget to Mention The Date",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueAccent),
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
                    'Sumbit',
                    textAlign: TextAlign.center,
                  )),
              onPressed: () async {
                await DataBaseHelperClass.instance.insert({
                  DataBaseHelperClass.columnTitle: task.text,
                  DataBaseHelperClass.columnDate: date.text,
                  DataBaseHelperClass.columnNote: about.text
                });
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(
                          title: '',
                        )));
              },
            ),
          ),
        ]));
  }
}
