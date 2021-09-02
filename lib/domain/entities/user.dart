class User{
  String _id = '';
  String _name = '';
  String _surname = '';
  String _email = '';

  static final String _idStr = 'id';
  static final String _nameStr = 'name';
  static final String _surnameStr = 'surname';
  static final String _emailStr = 'email';

  String get getId => _id;
  String get getName => _name;
  String get getSurname => _surname;
  String get getEmail => _email;

  User({required String id, required String name, required String surname, required String email}){
    _id = id;
    _name = name;
    _surname = surname;
    _email = email;
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(id: json[_idStr], name: json[_nameStr], surname: json[_surnameStr], email: json[_emailStr]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[_idStr] = this._id;
    data[_nameStr] = this._name;
    data[_surnameStr] = this._surname;
    data[_emailStr] = this._email;
    return data;
  }

  @override
  String toString() {
    return '{"$_idStr": "$_id", "$_nameStr": "$_name", "$_surnameStr": "$_surname", "$_emailStr": "$_email"}';
  }
}

class RegistrationUser{
  RegistrationUser(this._name, this._surname, this._email, this._password);

  final String _name;
  final String _surname;
  final String _email;
  final String _password;

  String get getName => _name;
  String get getSurname => _surname;
  String get getEmail => _email;
  String get getPassword => _password;
}