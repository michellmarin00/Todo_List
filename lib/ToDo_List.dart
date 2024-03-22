import 'package:flutter/material.dart';

void main() {
  runApp(AppMisTareas());
}

class AppMisTareas extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      home: TareasPantalla(),
    );
  }
}

class TareasPantalla extends StatefulWidget {
  _TareasPantallaState createState() => _TareasPantallaState();
}

class _TareasPantallaState extends State<TareasPantalla> {
  List<String> tareas = ['Tarea Numero 1', 'Tarea test 2', 'Tarea esta es la 3'];


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tareas[index]),
          );
        },
      ),
    );
  }
}