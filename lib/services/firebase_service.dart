import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getUsers() async {
  List<Map<String, dynamic>> users = [];
  CollectionReference collectionReferenceUser = db.collection('usuario');

  QuerySnapshot queryUser = await collectionReferenceUser.get();

  queryUser.docs.forEach((registro) {
    Map<String, dynamic> userData = registro.data() as Map<String, dynamic>;
    final user = {
      'id': registro.id,
      'nombre': userData['nombre'],
      'cedula': userData['cedula'],
      'correo': userData['correo'],
      'clave': userData['clave'],
    };
    users.add(user);
  });

  return users;
}

Future<void> addUser(Map<String, dynamic> userData) async {
  try {
    await db.collection('usuario').add(userData);
  } catch (e) {
    print('Error adding user: $e');
  }
}

Future<void> deleteUser(String documentId) async {
  try {
    await db.collection('usuario').doc(documentId).delete();
  } catch (e) {
    print('Error deleting user: $e');
  }
}

Future<void> updateUser(String documentId, Map<String, dynamic> newData) async {
  try {
    await db.collection('usuario').doc(documentId).set(newData);
  } catch (e) {
    print('Error updating user: $e');
  }
}


