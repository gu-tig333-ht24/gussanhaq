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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Att göra lista'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.dehaze), onPressed: () {})],
        backgroundColor: const Color.fromARGB(255, 255, 142, 28),
        elevation: 4,
        toolbarHeight: 45,
      ),
      body: ListView.builder(
        itemCount: task.length,
        itemBuilder: (context, index) {
          if (index == task.length) {
            return Divider(
              color: Colors.black,
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
            );
          }
          return Column(
            children: [
              TaskItem(task[index].task),
              Divider(
                color: Colors.black,
                thickness: 1.5,
                indent: 20,
                endIndent: 20,
              ),
            ],
          );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskPage()),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: const Color.fromARGB(255, 251, 145, 40),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String task;
  TaskItem(this.task, {super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.check_box_outline_blank),
            iconSize: 40,
          ),
        ),
        Expanded(
          child: Text(
            widget.task,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete),
          color: (Colors.black),
          iconSize: 33,
        ),
      ],
    );
  }
}

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lägg till uppgift'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 142, 28),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Skriv in uppgift',
              hintStyle: TextStyle(fontSize: 18),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                const Color.fromARGB(255, 251, 145, 40),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Lägg till',
                style: TextStyle(fontSize: 18, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
