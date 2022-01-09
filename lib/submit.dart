import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> submit(String name, int marks, int rollNo) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('students');
  try {
    await collectionReference
        .add({'Name': name, 'Marks': marks, 'roll_no': rollNo});
  } on Exception catch (e) {
    print(e.toString());
  }
}

Future<Map<String, dynamic>> getData() async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('students');
  DocumentSnapshot documentSnapshot =
      await collectionReference.doc('hRbYcxzTjyDHkc45tKzs').get();
  Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
  print(map);
  return map;
}
