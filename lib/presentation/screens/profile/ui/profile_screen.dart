import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/presentation/screens/main/ui/main_screen.dart';
import 'package:task_manager/presentation/screens/path_manager.dart';
import 'package:task_manager/presentation/screens/profile/cubit/profile_cubit.dart';
import 'package:task_manager/presentation/screens/validator.dart';
import 'package:task_manager/presentation/widgets/navigation_widget/navigation_widget.dart';

enum TypeUserEditDialog{name, password}

class ProfileScreen extends StatelessWidget{
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController surnameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();


  void setTextEditingControllers(ProfileCubit profileCubit){
    if(profileCubit.state is StartProfileState){
      profileCubit.initUser();
      nameTextEditingController.text = profileCubit.state.user.getName;
      surnameTextEditingController.text = profileCubit.state.user.getSurname;
      emailTextEditingController.text = profileCubit.state.user.getEmail;
    }
    else{
      nameTextEditingController.text = profileCubit.state.user.getName;
      surnameTextEditingController.text = profileCubit.state.user.getSurname;
      emailTextEditingController.text = profileCubit.state.user.getEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    setTextEditingControllers(profileCubit);
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, snapshot){
          if(!(profileCubit.state is ErrorProfileState)){
            return Scaffold(
                bottomNavigationBar: NavigationWidget(),
                body: Form(
                    key: _key,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).backgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Профиль', style: Theme.of(context).textTheme.headline2,),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          TextFormField(
                            style: Theme.of(context).textTheme.headline1,
                            enabled: false,
                            validator: Validator.validateName,
                            controller: nameTextEditingController,
                            decoration: new InputDecoration(
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black54)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                              counterStyle: Theme.of(context).textTheme.headline1,
                              labelStyle: Theme.of(context).textTheme.headline1,
                              labelText: "Имя",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          TextFormField(
                            enabled: false,
                            validator: Validator.validateName,
                            controller: surnameTextEditingController,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: new InputDecoration(
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black54)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                              counterStyle: Theme.of(context).textTheme.headline1,
                              labelStyle: Theme.of(context).textTheme.headline1,
                              labelText: "Фамилия",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          TextFormField(
                            enabled: false,
                            controller: emailTextEditingController,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: new InputDecoration(
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black54)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                              counterStyle: Theme.of(context).textTheme.headline1,
                              labelStyle: Theme.of(context).textTheme.headline1,
                              labelText: "Email",
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(onPressed: ()=> _userEditDialog(context, BlocProvider.of<ProfileCubit>(context), TypeUserEditDialog.password),
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).buttonColor
                                ),
                                child: Text('Сменить пароль', style: Theme.of(context).textTheme.headline1),),
                              ElevatedButton(onPressed: ()=> _userEditDialog(context, BlocProvider.of<ProfileCubit>(context), TypeUserEditDialog.name),
                                child: Text("Редактировать", style: Theme.of(context).textTheme.headline1,),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05), // put the width and height you want
                                    primary: Theme.of(context).buttonColor
                                ),),
                            ],)
                        ],),)));
          }
          else
            return Center(child: Text('Ошибка, данные пользователя не загрузились'));
        });
  }

  Future<void> _userEditDialog(BuildContext context, ProfileCubit profileCubit, TypeUserEditDialog typeUserEditDialog) async {
    final TextEditingController _textEditingController1 = TextEditingController();
    final TextEditingController _textEditingController2 = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          GlobalKey<FormState> _key = GlobalKey<FormState>();
          return AlertDialog(
            title: Text('Радактирование пользователя'),
            content: Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: Validator.validateName,
                      controller: _textEditingController1,
                      decoration: InputDecoration(hintText: typeUserEditDialog == TypeUserEditDialog.name ? "Имя" : "Новый пароль"),
                    ),
                    TextFormField(
                      validator: Validator.validateName,
                      controller: _textEditingController2,
                      decoration: InputDecoration(hintText: typeUserEditDialog == TypeUserEditDialog.name ? "Фамилия" : "Повторите пароль"),
                    ),
                  ],)),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () => PathManager.goPage(MainScreen.ROUTE_NAME, context, 1),
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () async{
                  if(_key.currentState!.validate()){
                    if(typeUserEditDialog == TypeUserEditDialog.name){
                      User newUser = User(id: profileCubit.state.user.getId, name: _textEditingController1.text,
                          surname: _textEditingController2.text, email: profileCubit.state.user.getEmail);
                      profileCubit.updateNameAndSurname(newUser);
                    }
                    else{
                      if(_textEditingController1.text.compareTo(_textEditingController2.text) == 0)
                        profileCubit.updatePassword(_textEditingController1.text);
                      else
                        Fluttertoast.showToast(
                            msg: "Пароли не совпадают",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                    }

                    PathManager.goPage(MainScreen.ROUTE_NAME, context, 1);
                  }
                },
              ),
            ],
          );
        });
  }
}