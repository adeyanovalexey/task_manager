class UserDTO{
  UserDTO(this._id, this._name, this._surname);
  final String _id;
  final String _name;
  final String _surname;

  static final String _idStr = 'id';
  static final String _nameStr = 'name';
  static final String _surnameStr = 'surname';

  String get getId => _id;
  String get getName => _name;
  String get getSurname => _surname;

  static UserDTO fromJson(Map<String, dynamic> json) {
    return UserDTO(json[_idStr], json[_nameStr], json[_surnameStr]);
  }

  Map<String, dynamic> toJson([bool addId = true]) {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if(addId)
      data[_idStr] = this._id;

    data[_nameStr] = this._name;
    data[_surnameStr] = this._surname;
    return data;
  }
}