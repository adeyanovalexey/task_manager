class Validator{

  static String? validatePassword(String? value) {
    final String pattern =
        r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{4,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if(value.length < 4)
        return 'Enter more than 4 characters';
      if (!regex.hasMatch(value))
        return 'Enter at least 1 letter and 1 digit';
      else
        return null;
    }
  }

  static String? validateName(String? value) {
    final String pattern =
        r'^([a-zA-Zа-яА-Я]).{2,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value == null || value.isEmpty) {
      return 'Введите имя';
    }
    else if (!regex.hasMatch(value))
      return 'меньше 3 букв';
    else
      return null;

  }

  static String? validateEmail(String? value) {
    final String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if(value == null || !regex.hasMatch(value)){
      return 'Enter a valid email address';
    }
    else
      return null;
  }
}