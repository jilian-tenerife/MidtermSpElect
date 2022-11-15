import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:todo/components/dialog_box.dart';
import 'package:todo/components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoList = [
    ["sample task", false],
    ["sample task#2", false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    String greetingMessage() {
      var timeNow = DateTime.now().hour;

      if (timeNow <= 12) {
        return ' Good Morning';
      } else if ((timeNow > 12) && (timeNow <= 16)) {
        return 'Good Afternoon';
      } else if ((timeNow > 16) && (timeNow < 20)) {
        return 'Good Evening';
      } else {
        return 'Good Night';
      }
    }

    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: const Color(0xffabb7c8),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            backgroundColor: const Color(0xff7484a6),
            title: Text(
              greetingMessage(),
              style: const TextStyle(fontSize: 30),
            ),
            actions: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/pp.png"), fit: BoxFit.cover),
                  color: const Color(0xFF6181BE),
                  border: Border.all(
                    color: const Color(0xFFEB9EB2),
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffdadadb),
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: toDoList[index][0],
              taskCompleted: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
      ),
    );
  }
}
