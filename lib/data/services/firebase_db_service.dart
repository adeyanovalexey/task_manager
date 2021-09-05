import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService{

  FirebaseApp? _firebaseApp;
  FirebaseDatabase? _database;
  FirebaseDatabaseService(this._firebaseApp){
    _database = FirebaseDatabase(app: _firebaseApp);
  }


  dynamic read(String path, [String? id]) async{
    DatabaseReference _databaseReference;
    if(id != null)
      _databaseReference = _database!.reference().child(path + '/' + id);
    else
      _databaseReference = _database!.reference().child(path);

    DataSnapshot snapshot = await _databaseReference.once();
    return snapshot.value;
  }

  Future<void> write(String path, dynamic value, [String? id]) async{
    if(id != null)
      await FirebaseDatabase.instance.reference().child(path).child(id).set(value);
    else
      await FirebaseDatabase.instance.reference().child(path).push().set(value);
  }

  Future<void> update(String path, String id, Map<String, dynamic>  value) async{
    await _database!.reference().child(path + "/" + id).update(value);
  }
}