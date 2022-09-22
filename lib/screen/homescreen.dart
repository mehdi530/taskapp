import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskapp/models/task_model.dart';
import 'package:taskapp/screen/addscreen.dart';
import 'package:taskapp/screen/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class homescreen extends StatelessWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(""),
        //leading: const Icon(
        // Icons.menu_outlined,
        // color: Colors.blueGrey,
        //),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.blueGrey,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mynavigator(context, 'add', -1, "");
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My To Do List",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "To Day Task",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: Hive.openBox('taskbox'),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return tasklist();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget tasklist() {
    Box taskbox = Hive.box('taskbox');

    return ValueListenableBuilder(
      valueListenable: taskbox.listenable(),

      builder: (context, Box box, child) {
        if (taskbox.isEmpty) {
          return const Center(
            child: Text("No Data",
                style: TextStyle(color: Colors.redAccent, fontSize: 20)),
          );
        }else{
        return SizedBox(
          height: 452,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: taskbox.length,
            itemBuilder: (context, index) {
              final task_model t_m = box.getAt(index);
              return GestureDetector(
                  onDoubleTap: () {
                    mynavigator(context, 'update', index, t_m.task_text);
                  },
                  child: Card(
                    color: blue1,
                    child: ListTile(
                      leading: Icon(Icons.dashboard_outlined),
                      title:
                          Text(t_m.task_text, style: TextStyle(fontSize: 20)),
                      trailing: IconButton(
                          onPressed: () {
                            remoev(index);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black54,
                            size: 40,
                          )),
                    ),
                  ));
            },
          ),
        );
      }},
    );
  }

  void mynavigator(context, String type, int index, String text) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => addscreen(
            type: type,
            index: index,
            text: text,
          ),
        ));
  }

  void remoev(index) {
    Box box = Hive.box('taskbox');
    box.deleteAt(index);
  }
}
