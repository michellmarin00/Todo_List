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
  final _formKey = GlobalKey<FormState>();
  String _nombreTarea = '';
  String _descripcionTarea = '';

  void _agregarTarea() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        tareas.add('$_nombreTarea - $_descripcionTarea');
        _nombreTarea = '';
        _descripcionTarea = '';
      });
      Navigator.of(context).pop();
    }
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Agregar Tarea'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nombre de la tarea',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingrese un nombre';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _nombreTarea = value!;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Descripción de la tarea',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingrese una descripción';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _descripcionTarea = value!;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: _agregarTarea,
                    child: Text('Agregar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}