import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/models/task_model.dart';
import 'homescreen.dart';

class addscreen extends StatelessWidget {
  addscreen(
      {Key? key, required this.type, required this.index, required this.text})
      : super(key: key);
  final String type;
  final int index;
  final String text;

  TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (type == "update") {
      controller1.text = text;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(type == 'add' ? 'Add Task' : 'Update Task'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller1,
            style: TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                label: Text('type...')),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              onclick_button(context,controller1.text);
            },
            child: Text(type == 'add' ? 'Add' : 'Update'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                fixedSize: MaterialStateProperty.all(const Size(150, 60))),
          )
        ]),
      ),
    );
  }

  void onclick_button(context,String text) {
    if (type == 'add') {
      add(text);
    } else {
      update(text);
    }
    controller1.text="" ;
    Navigator.pop(context);
  }

  add(String text) async {
    var box = await Hive.box('taskbox');
    task_model t_m = task_model(text);
    box.add(t_m);
  }

  update(String text) async {
    var box = await Hive.box('taskbox');
    task_model t_m = task_model(text);
    box.putAt(index, t_m);

  }
}
