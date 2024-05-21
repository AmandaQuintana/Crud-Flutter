import 'package:crud_firebase/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUsers(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final users = snapshot.data ?? [];
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Dismissible(
                  onDismissed: (direction) async {
                    await deleteUser(userData['id']);
                    setState(() {
                      users.removeAt(index);
                    });
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('¿Está seguro de querer eliminar el usuario?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );

                    return result;
                  },
                  background: Container(
                    color: const Color.fromARGB(255, 217, 216, 216),
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.startToEnd,
                  key: Key(userData['id']),
                  child: ListTile(
                    title: Text(
                      userData['nombre'] ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cedula: ${userData['cedula'] ?? ''}'),
                        Text('Correo: ${userData['correo'] ?? ''}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/update',
                        arguments: userData,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
