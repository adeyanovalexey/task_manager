enum Status{ToDo, InProgress, Testing, Done}

class Task{
  String _id = '';
  String _name = '';
  String _description = '';
  String _idAuthor= '';
  Status _status = Status.ToDo;

  final String _idStr = 'id';
  final String _nameStr = 'name';
  final String _descriptionStr = 'description';
  final String _idAuthorStr = 'idAuthor';
  final String _statusStr = 'status';

  Task({required String id, required String name, required String description, required String idAuthor,
    required Status status}){
    _id = id;
    _name = name;
    _description = description;
    _idAuthor = idAuthor;
    _status = status;
  }

  Task.newTask({required String name, required String description, required String idAuthor,
    required Status status}){
    _name = name;
    _description = description;
    _idAuthor = idAuthor;
    _status = status;
  }

  set setName(String value) {_name = value;}
  set setDescription(String value) {_description = value;}
  set setIdAuthor(String value) {_idAuthor = value;}
  set setStatus(Status value) {_status = value;}


  String get getId => _id;
  String get getName => _name;
  String get getDescription => _description;
  String get getIdAuthor => _idAuthor;
  Status get getStatus => _status;

  Task.fromJson(Map<String, dynamic> json, {String? id}) {
    if(id != null)
      _id = id;
    else
      _id = json[_idStr];

    _name = json[_nameStr];
    _description = json[_descriptionStr];
    _idAuthor = json[_idAuthorStr];
    _status = Status.values[json[_statusStr]];
  }

  Map<String, dynamic> toJson([bool addId = true]) {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if(addId)
      data[_idStr] = this._id;

    data[_nameStr] = this._name;
    data[_descriptionStr] = this._description;
    data[_idAuthorStr] = this._idAuthor;
    data[_statusStr] = this._status.index;
    return data;
  }

  @override
  String toString() {
    return '{ "$_idStr": "$_id", "$_nameStr": "$_name", "$_descriptionStr": "$_description", '
        '"$_idAuthorStr": "$_idAuthor",  "$_statusStr" : "${_status.index.toString()}"}';
  }
}