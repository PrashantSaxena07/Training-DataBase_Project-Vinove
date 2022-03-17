import 'package:database_sample/database/database_helper.dart';
import 'package:database_sample/screens/add_task.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoad=false;
  @override
  void initState() {

    setState(() {
      isLoad=true;
    });

    fetchData();

    setState(() {
      isLoad=false;
    });

    super.initState();
  }

  List<Map<String, dynamic>> rows = [];

  fetchData() async {
    rows = await DataBaseHelperClass.instance.queryAll();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "To-Do List",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 28),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddTask()));
          },
        ),
        body:
            isLoad?Center(child: CircularProgressIndicator(
              color: Colors.black,
            ),):
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: rows.length,
              itemBuilder: (context, index) => Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    title: Text(rows[index]['Title'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18)),
                    subtitle: Text(rows[index]['Note'],
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 14)),
                    trailing: Text(rows[index]['CreatedOn'],
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                  ))),
        ));
  }
}
