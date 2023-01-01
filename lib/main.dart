import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool addTask = false;
  List tasks = <dynamic>[];
  String taskName = "";
  dynamic taskPriority = "Not Urgent";
  String taskDescription = "";
  TextDecoration completed = TextDecoration.none;
  DateTime selectedDate = DateTime.now();
  

  Future getAllTasks() async {
    final SharedPreferences userTasks = await SharedPreferences.getInstance();
  }

  createUserTask() {
    setState(() {
        if (taskName == "") return;
        if (taskName.length < 3) return;
        if (taskDescription == "") {
          setState(() {
            taskDescription = "No Description";
          });
        }
            tasks.add({"name": taskName, "priority": taskPriority, "date": "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}", "description": taskDescription});
            taskName = "";
            taskPriority = "Not Urgent";
            taskDescription = "";
            addTask = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return addTask == false ? 
    Scaffold(
      appBar: AppBar(
        title: Text("TaskUp ${tasks.length}"),
        actions: [
          tasks.length != 0 ?
          IconButton(onPressed: () {
            setState(() {
              tasks.clear();
            });
          }, icon: Icon(Icons.delete))
          : IconButton(
            onPressed: () {
              setState(() {
                addTask =true;
              });
            }, icon: Icon(Icons.add)
            )
        ],
      ),
      body: Center(
        child: Container(
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.pink,
            Colors.purple,
            Colors.lightBlue,
          ])),
          child: tasks.length != 0 ? ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
              return ListTile(
                      title: Text(tasks[index]["description"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, decoration: completed, fontSize: 12), textAlign: TextAlign.left, maxLines: 1,) ,
                      subtitle: Text("Name: " + tasks[index]["name"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, decoration: completed, fontSize: 11), textAlign: TextAlign.left,),
                      leading: Icon(Icons.task),
                      trailing: Text(tasks[index]["date"].toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, decoration: completed, fontSize: 12),),
                      //contentPadding: EdgeInsets.all(16),
                      onTap: () {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                    );
            },
          )
          : Center(child: Text("Add a task", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w900),))
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          setState(() {
            addTask = true;
          });
        }),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    )
    : Scaffold(
      appBar: AppBar(
        title: Text("TaskUp"),
        actions: [
          IconButton(
            onPressed: (() {
              setState(() {
                addTask = false;
              });
            }), icon: Icon(Icons.exit_to_app),
            tooltip: "Go Back",
            )
        ],
      ),
      body: Center(
        child: Container(
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.pink,
            Colors.purple,
            Colors.lightBlue,
          ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Padding(padding: EdgeInsets.all(16)),
                SizedBox(
                  width: (MediaQuery.of(context).size.height) - 250,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLength: 15,
                    onChanged: (value) {
                      setState(() {
                        taskName = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Name",
                      hintText: "Task Name",
                      icon: Icon(Icons.book),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(16)),
                 SizedBox(
                  width: (MediaQuery.of(context).size.height) - 250,
                  child: TextField(
                    maxLength: 40,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        taskDescription = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Description",
                      hintText: "Short Task Description",
                      icon: Icon(Icons.note_add_sharp),
                    ),
                  ),
                ),
                  /*DropdownButton(
                    value: taskPriority,
                    dropdownColor: Colors.lightBlue,
                    icon: Icon(Icons.menu, color: Colors.lightBlueAccent,),
                    onChanged: (value) {
                      setState(() {
                        taskPriority = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: "Not Urgent",
                        child: Text("Not Urgent")),
                         DropdownMenuItem(
                        value: "Kindof Urgent",
                        child: Text("Kindof Urgent")),
                         DropdownMenuItem(
                        value: "Urgent",
                        child: Text("Urgent")),
                         DropdownMenuItem(
                        value: "Very Urgent",
                        child: Text("Very Urgent")),
                    ]
                  ),*/
                Text(
                  "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}"
                ),
                Padding(padding: EdgeInsets.all(2)),
                ElevatedButton(
                  onPressed: () async {
                 final DateTime? dateTime = await showDatePicker(
                      context: context, initialDate: selectedDate, firstDate: DateTime.now(), lastDate: DateTime(2200)
                      );
                      if (dateTime != null) {
                        setState(() {
                          selectedDate = dateTime;
                        });
                      }
                   }, 
                  child: Text("Choose due date")
                  ),
              ],
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createUserTask,
        tooltip: 'Create Task',
        child: const Icon(Icons.check),
      ),
    );
  }
}
