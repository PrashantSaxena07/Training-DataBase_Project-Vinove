import 'package:aditya6015sqfliteproject/Screens/to_do_screen.dart';
import 'package:aditya6015sqfliteproject/database/databse_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required String title}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Map<String,dynamic>> rows=[];

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  fetchData()async{
    rows= await DataBaseHelperClass.instance.queryAll();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("All List"),
        leading: Icon(Icons.sticky_note_2),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: rows.length,
          itemBuilder: (context, index) => Container(
              width: size.width * 0.9,
              height: size.height*0.1,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(

                title: Text(rows[index]['Title'],
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                subtitle: Text(rows[index]['Note'],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 15)),
                trailing: Text(rows[index]['Date'],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Floating()));
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
      ),
    );
  }
}
