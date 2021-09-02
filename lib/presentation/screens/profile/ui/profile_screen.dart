import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/domain/entities/user.dart';
import 'package:task_manager/presentation/screens/profile/cubit/profile_cubit.dart';
import 'package:task_manager/presentation/screens/validator.dart';
import 'package:task_manager/task_manager.dart';
enum TypeUserEditDialog{name, password}

class ProfileScreen extends StatelessWidget{
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController surnameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();

  @override
  StatelessElement createElement(){
    if(ProfileCubit.instance.state is StartProfileState)
      ProfileCubit.instance.initUser().then((value){
        nameTextEditingController.text = ProfileCubit.instance.state.user.getName;
        surnameTextEditingController.text = ProfileCubit.instance.state.user.getSurname;
        emailTextEditingController.text = ProfileCubit.instance.state.user.getEmail;
      });
    else{
      nameTextEditingController.text = ProfileCubit.instance.state.user.getName;
      surnameTextEditingController.text = ProfileCubit.instance.state.user.getSurname;
      emailTextEditingController.text = ProfileCubit.instance.state.user.getEmail;
    }
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return BlocProvider<ProfileCubit>(
        create: (_) => ProfileCubit.instance,
        child: BlocBuilder<ProfileCubit, ProfileState>(
            bloc:   ProfileCubit.instance,
            builder: (context, snapshot){
              return Form(
                  key: _key,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.yellow,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          child:TextFormField(
                            enabled: false,
                            validator: Validator.validateName,
                            controller: nameTextEditingController,
                            decoration: new InputDecoration(
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black54)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                              counterStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Имя",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Container(
                          color: Colors.white,
                          child:TextFormField(
                            enabled: false,
                            validator: Validator.validateName,
                            controller: surnameTextEditingController,
                            decoration: new InputDecoration(
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black54)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                              counterStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Фамилия",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Container(
                          color: Colors.white,
                          child:TextFormField(
                            enabled: false,
                            controller: emailTextEditingController,
                            decoration: new InputDecoration(
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black54)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                              counterStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(onPressed: ()=> _userEditDialog(context, BlocProvider.of<ProfileCubit>(context), TypeUserEditDialog.password),
                              child: Text('Сменить пароль'),),
                            ElevatedButton(onPressed: ()=> _userEditDialog(context, BlocProvider.of<ProfileCubit>(context), TypeUserEditDialog.name),
                              child: Text("Редактировать"),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                              ),),
                          ],)
                      ],),));}));
  }

  Future<void> _userEditDialog(BuildContext context, ProfileCubit profileCubit, TypeUserEditDialog typeUserEditDialog) async {
    final TextEditingController _textEditingController1 = TextEditingController();
    final TextEditingController _textEditingController2 = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Радактирование пользователя'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _textEditingController1,
                  decoration: InputDecoration(hintText: typeUserEditDialog == TypeUserEditDialog.name ? "Имя" : "Новый пароль"),
                ),
                TextField(
                  controller: _textEditingController2,
                  decoration: InputDecoration(hintText: typeUserEditDialog == TypeUserEditDialog.name ? "Фамилия" : "Повторите пароль"),
                ),
              ],),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () => TaskManager.goPage(TaskManager.profilePath, context),
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () async{
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

                  TaskManager.goPage(TaskManager.profilePath, context);
                },
              ),
            ],
          );
        });
  }
}