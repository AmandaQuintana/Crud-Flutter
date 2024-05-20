import 'package:flutter/material.dart';
import 'package:crud_firebase/services/firebase_service.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({Key? key}) : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  String documentId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    documentId = arguments['id'] ?? '';
    nameController.text = arguments['nombre'] ?? '';
    idController.text = arguments['cedula'] ?? '';
    emailController.text = arguments['correo'] ?? '';
    passwordController.text = arguments['clave'] ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Nombre',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Cedula',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Correo',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Clave',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final userData = {
                  'nombre': nameController.text,
                  'cedula': idController.text,
                  'correo': emailController.text,
                  'clave': passwordController.text,
                };
                await updateUser(documentId, userData).then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
