import 'package:flutter/material.dart';
import 'package:project/components/tasks.dart';
import 'package:project/data/task_inherit.dart';
import 'package:project/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter: Primeiros Passos'),
        leading: Icon(Icons.add_task),
      ),
      body: Container(
        color: Color.fromARGB(255, 208, 221, 237),
        child: ListView(
          children: TaskInherited.of(context)!.taskList,
        
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context,),
            ),
          );
        },
        backgroundColor: Colors.blue[100],
        child: const Icon(Icons.add),
      ),
    );
  }
}
