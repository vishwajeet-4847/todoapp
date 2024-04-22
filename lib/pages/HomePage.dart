import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/util/dialog_box.dart';
import 'package:todo_list/util/tidi_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    ///if this is the firsttime  opening the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final TextEditingController myTextController = TextEditingController();

  //changing checkbox
  void checkBOxChanged(bool? value, int index) {
    setState(() {
      db.toDOList[index][1] = !db.toDOList[index][1];
    });
    db.updateData();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDOList.add([myTextController.text, false]);
      myTextController.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  //creating new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: myTextController,
            onSave: saveNewTask,
          );
        });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDOList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text("TODO LIST")),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDOList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDOList[index][0],
            taskCompleted: db.toDOList[index][1],
            onChanged: (value) => checkBOxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
