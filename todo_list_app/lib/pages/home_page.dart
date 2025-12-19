import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [];
  String filter = "all"; // all, completed, incomplete

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString("todos");
    if (jsonData != null) {
      List decoded = jsonDecode(jsonData);
      setState(() {
        todos = decoded.map((e) => Todo.fromJson(e)).toList();
      });
    }
  }

  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("todos",
        jsonEncode(todos.map((item) => item.toJson()).toList()));
  }

  // Add Todo
  void addTodo() {
    TextEditingController c = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Todo"),
        content: TextField(
          controller: c,
          decoration: const InputDecoration(
            hintText: "Tulis judul todo...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (c.text.isNotEmpty) {
                setState(() {
                  todos.add(
                    Todo(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      title: c.text,
                      createdAt: DateTime.now(),
                    ),
                  );
                });
                saveTodos();
                Navigator.pop(context);
              }
            },
            child: const Text("Tambah"),
          ),
        ],
      ),
    );
  }

  // Edit Todo
  void editTodo(Todo todo) {
    TextEditingController c = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Todo"),
        content: TextField(controller: c),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                todo.title = c.text;
              });
              saveTodos();
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  List<Todo> getFiltered() {
    if (filter == "completed") {
      return todos.where((t) => t.isCompleted).toList();
    } else if (filter == "incomplete") {
      return todos.where((t) => !t.isCompleted).toList();
    }
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    var data = getFiltered();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List Pink"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: "all", child: Text("Semua")),
              PopupMenuItem(value: "completed", child: Text("Selesai")),
              PopupMenuItem(value: "incomplete", child: Text("Belum Selesai")),
            ],
          )
        ],
      ),

      // Body
      body: data.isEmpty
          ? const Center(
              child: Text(
                "Tidak ada todo",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                Todo item = data[i];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: Checkbox(
                      value: item.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          item.isCompleted = value!;
                        });
                        saveTodos();
                      },
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: item.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: item.isCompleted
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.pink),
                          onPressed: () => editTodo(item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              todos.remove(item);
                            });
                            saveTodos();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
