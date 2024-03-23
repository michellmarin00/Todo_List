import 'package:flutter/material.dart';

void main() {
  runApp(AppMisTareas());
}

class AppMisTareas extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      home: PantallaTareas(),
    );
  }
}

class PantallaTareas extends StatefulWidget {
  _PantallaTareasState createState() => _PantallaTareasState();
}

class _PantallaTareasState extends State<PantallaTareas> {
  List<Map<String, dynamic>> tareas = [
    {'nombre': 'Tarea Número 1', 'descripcion': '', 'completada': false},
    {'nombre': 'Tarea de prueba 2', 'descripcion': '', 'completada': false},
    {'nombre': 'Tarea esta es la 3', 'descripcion': '', 'completada': false},
  ];

  final _formKey = GlobalKey<FormState>();
  String _nombreTarea = '';
  String _descripcionTarea = '';

  void _agregarTarea() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        tareas.add({
          'nombre': _nombreTarea,
          'descripcion': _descripcionTarea,
          'completada': false,
        });
        _nombreTarea = '';
        _descripcionTarea = '';
      });
      Navigator.of(context).pop();
    }
  }

  void _marcarCompletada(int index) {
    setState(() {
      tareas[index]['completada'] = !tareas[index]['completada'];
    });
  }

  void _eliminarTarea(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar tarea'),
          content: Text('¿Está seguro de que desea eliminar esta tarea?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tareas.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Sí'),
            ),
          ],
        );
      },
    );
  }
// lista tareas completadas
  void _mostrarTareasCompletadas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaListaTareasCompletadas(
          titulo: 'Tareas Completadas',
          tareas: obtenerTareasCompletadas(),
        ),
      ),
    );
  }
  List<Map<String, dynamic>> obtenerTareasCompletadas() {
    return tareas.where((tarea) => tarea['completada'] == true).toList();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _mostrarTareasCompletadas,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: tareas[index]['completada'],
              onChanged: (value) {
                _marcarCompletada(index);
              },
            ),
            title: Text(
              tareas[index]['nombre'],
              style: TextStyle(
                decoration: tareas[index]['completada']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(tareas[index]['descripcion']),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _eliminarTarea(index);
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
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
        child: Text('Agregar Tarea'),
      ),
    );
  }
}
class PantallaListaTareasCompletadas extends StatelessWidget {
  final String titulo;
  final List<Map<String, dynamic>> tareas;

  PantallaListaTareasCompletadas({required this.titulo, required this.tareas});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tareas[index]['nombre']),
            subtitle: Text(tareas[index]['descripcion']),
          );
        },
      ),
    );
  }
}