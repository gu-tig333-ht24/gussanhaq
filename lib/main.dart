import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Att göra lista',
      home: HomePage(),
    );
  }
}

class Task {
  final String task;

  Task(this.task);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> task = [
      Task('Köpa mjölk'),
      Task('Köpa ägg'),
      Task('Kratta löv'),
      Task('Klappa hunden'),
      Task('Mata barnen'),
      Task('Såga brädor'),
      Task("Gymma"),
      Task('Köpa mjölk'),
      Task('Köpa ägg'),
      Task('Kratta löv'),
      Task('Klappa hunden'),
      Task('Mata barnen'),
      Task('Såga brädor'),
      Task("Gymma"),
      Task('Köpa mjölk'),
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Att göra lista'),
          centerTitle: true,
          actions: [IconButton(icon: Icon(Icons.dehaze), onPressed: null)],
          backgroundColor: const Color.fromARGB(255, 255, 142, 28),
          elevation: 4,
          toolbarHeight: 45,
        ),
        body: ListView.separated(
          itemCount: task.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            return TaskItem(task[index].task);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 35),
            child: SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  //Framtida logik
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 251, 145, 40),
                child: Icon(Icons.add),
              ),
            )));
  }
}

class TaskItem extends StatelessWidget {
  final String task;
  TaskItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black,
                width: 2.5,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            task,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.delete,
            size: 30,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MyApp());
}
