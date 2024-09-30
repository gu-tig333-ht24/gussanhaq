import 'dart:convert';
import './main.dart';
import 'package:http/http.dart' as http;

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
const String API_KEY = 'fdbd44e7-34e3-4e7a-9ecd-78edc0b34152';

Future<void> PostTask(Task task) async {
  await http.post(
    Uri.parse('$ENDPOINT/todos?key=$API_KEY'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
      {'title': task.task, 'done': task.isDone},
    ),
  );
}

Future<List<Task>> GetTasks() async {
  http.Response response =
      await http.get(Uri.parse('$ENDPOINT/todos?key=$API_KEY'));
  String body = response.body;

  var data = jsonDecode(body);

  var tasks = data.map<Task>((task) => Task.fromJson(task)).toList();
  return tasks;
}

Future<void> DeleteTask(String id) async {
  await http.delete(Uri.parse('$ENDPOINT/todos/$id?key=$API_KEY'));
}

Future<void> UpdateTaskCheck(Task task) async {
  await http.put(
    Uri.parse('$ENDPOINT/todos/${task.id}?key=$API_KEY'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
      {'title': task.task, 'done': task.isDone = !task.isDone},
    ),
  );
}
