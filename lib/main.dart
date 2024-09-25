import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyState extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String newTask) {
    _tasks.add(Task(newTask));
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.removeWhere((t) => t == task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }
  }
}

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
  bool isDone;

  Task(this.task, {this.isDone = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task && other.task == task;
  }

  @override
  int get hashCode => task.hashCode;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Filter _filter = Filter.all;

  @override
  Widget build(BuildContext context) {
    List<Task> task = context.watch<MyState>().tasks;

    List<Task> filteredTasks;
    switch (_filter) {
      case Filter.completed:
        filteredTasks = task.where((task) => task.isDone).toList();
        break;
      case Filter.incomplete:
        filteredTasks = task.where((task) => !task.isDone).toList();
        break;
      case Filter.all:
      default:
        filteredTasks = task;
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 216, 177),
      appBar: AppBar(
        title: const Text('Att göra lista'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<Filter>(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            color: const Color.fromARGB(255, 254, 216, 177),
            onSelected: (Filter result) {
              setState(
                () {
                  _filter = result;
                },
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Filter>>[
              const PopupMenuItem<Filter>(
                value: Filter.all,
                child: Text('Alla'),
              ),
              const PopupMenuItem<Filter>(
                value: Filter.completed,
                child: Text('Klara'),
              ),
              const PopupMenuItem<Filter>(
                value: Filter.incomplete,
                child: Text('Ej klara'),
              ),
            ],
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 111, 78, 55),
        toolbarHeight: 45,
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          return TaskItem(filteredTasks[index],
              key: Key(filteredTasks[index].task));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 55),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskPage()),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: const Color.fromARGB(255, 111, 78, 55),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

enum Filter {
  all,
  completed,
  incomplete,
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(0, 85),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color.fromARGB(255, 219, 169, 121),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<MyState>().toggleTask(task);
              },
              icon: Icon(task.isDone
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              iconSize: 40,
              color: Colors.black,
            ),
            Expanded(
              child: Text(
                task.task,
                style: TextStyle(
                  fontSize: 22,
                  color: task.isDone ? Colors.grey : Colors.black,
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<MyState>().removeTask(task);
              },
              icon: const Icon(Icons.delete),
              color: Colors.black,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 216, 177),
      appBar: AppBar(
        title: const Text('Lägg till uppgift'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 111, 78, 55),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Skriv in uppgift',
              hintStyle: TextStyle(fontSize: 18),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                const Color.fromARGB(255, 111, 78, 55),
              ),
            ),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                context.read<MyState>().addTask(_controller.text);
              }
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
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyState(),
      child: const MyApp(),
    ),
  );
}
