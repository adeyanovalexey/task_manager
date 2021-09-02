import 'package:task_manager/domain/entities/task.dart';

class FullTask{
  String _id = '';
  String _name = '';
  String _description = '';
  String _nameAuthor= '';
  Status _status = Status.ToDo;

  final String _idStr = 'id';
  final String _nameStr = 'name';
  final String _descriptionStr = 'description';
  final String _nameAuthorStr = 'nameAuthor';
  final String _statusStr = 'status';

  FullTask({required String id, required String name, required String description, required String nameAuthor,
    required Status status}){
    _id = id;
    _name = name;
    _description = description;
    _nameAuthor = nameAuthor;
    _status = status;
  }

  FullTask.newTask({required String name, required String description, required String nameAuthor,
    required Status status}){
    _name = name;
    _description = description;
    _nameAuthor = nameAuthor;
    _status = status;
  }

  set setName(String value) {_name = value;}
  set setDescription(String value) {_description = value;}
  set setNameAuthor(String value) {_nameAuthor = value;}
  set setStatus(Status value) {_status = value;}


  String get getId => _id;
  String get getName => _name;
  String get getDescription => _description;
  String get getNameAuthor => _nameAuthor;
  Status get getStatus => _status;

  FullTask.fromJson(Map<String, dynamic> json) {
    _id = json[_idStr];
    _name = json[_nameStr];
    _description = json[_descriptionStr];
    _nameAuthor = json[_nameAuthorStr];
    _status = Status.values[json[_statusStr]];
  }

  Map<String, dynamic> toJson([bool addId = true]) {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if(addId)
      data[_idStr] = this._id;

    data[_nameStr] = this._name;
    data[_descriptionStr] = this._description;
    data[_nameAuthorStr] = this._nameAuthor;
    data[_statusStr] = this._status.index;
    return data;
  }

  @override
  String toString() {
    return '{ "$_idStr": "$_id", "$_nameStr": "$_name", "$_descriptionStr": "$_description", '
        '"$_nameAuthorStr": "$_nameAuthor",  "$_statusStr" : ${_status.index.toString()}}';
  }
}