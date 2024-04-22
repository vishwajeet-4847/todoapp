import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  //refernce the box
  List toDOList = [];
  final _myBox = Hive.box("mybox");
  void createInitialData() {
    toDOList = [
      ["make tutorial", false],
      ["do exercise", false]
    ];
  }

  void loadData() {
    toDOList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", toDOList);
  }
}
