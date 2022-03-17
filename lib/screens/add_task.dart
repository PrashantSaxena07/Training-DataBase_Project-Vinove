import 'package:database_sample/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/database_helper.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initdB();

    super.initState();
  }
  void initdB(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Task",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 28),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: "What's this is todo for",
                  fillColor: Colors.white70),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Note",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: "write about your todo",
                  fillColor: Colors.white70),
            ),
            SizedBox(
              height: 12,
            ),
            // Text(
            //   "Date",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.w600,
            //       fontSize: 18),
            // ),
            // TextField(
            //   controller: _dateController,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //       filled: true,
            //       hintStyle: TextStyle(color: Colors.grey[400]),
            //       hintText: "date for your todo",
            //       fillColor: Colors.white70),
            // ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  final DateTime now = DateTime.now();
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  final String formatted = formatter.format(now);



                  await DataBaseHelperClass.instance.insert(
                      {

                    DataBaseHelperClass.columnTitle: _titleController.text,
                    // DataBaseHelperClass.columnDate: _dateController.text,
                    DataBaseHelperClass.columnCreatedOn:formatted,
                    DataBaseHelperClass.columnNote: _noteController.text

                  }
                  );
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddTask()));
                  // Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Your Todo is added successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "create todo",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
