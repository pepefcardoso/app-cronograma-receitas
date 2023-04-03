import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final referenciaUsuarios = FirebaseFirestore.instance.collection('users');

final referenciaImagens = FirebaseStorage.instance;
