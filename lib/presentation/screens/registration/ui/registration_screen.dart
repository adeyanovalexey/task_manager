import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/presentation/screens/registration/cubit/registration_cubit.dart';
import 'package:task_manager/presentation/screens/validator.dart';
import 'package:task_manager/task_manager.dart';

class RegistrationScreen extends StatelessWidget{
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController surnameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return BlocProvider<RegistrationCubit>(
        create: (_) => RegistrationCubit.instance,
        child: BlocBuilder<RegistrationCubit, RegistrationState>(
            bloc:   RegistrationCubit.instance,
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
                            validator: Validator.validateEmail,
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
                        Container(
                          color: Colors.white,
                          child:TextFormField(
                            validator: Validator.validatePassword,
                            controller: passwordTextEditingController,
                            decoration: new InputDecoration(
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black54)),
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                              counterStyle: TextStyle(color: Colors.black),
                              labelStyle: TextStyle(color: Colors.black),
                              labelText: "Пароль",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5.0),
                              ),),
                            onChanged: (value){},),),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        ElevatedButton(
                          onPressed: () async{
                            if(_key.currentState!.validate()){
                              await BlocProvider.of<RegistrationCubit>(context).registration(
                                  name: nameTextEditingController.text, surname: surnameTextEditingController.text,  email: emailTextEditingController.text, password: passwordTextEditingController.text
                              );
                              RegistrationState registrationState = BlocProvider.of<RegistrationCubit>(context).state;
                              if(registrationState == RegistrationState.done)
                                TaskManager.goPage(TaskManager.homePath, context);
                              else
                                Fluttertoast.showToast(
                                    msg: "Данный логин зарегистрован",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                            }
                          },
                          child: Text("Регистрация"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                          ),),
                      ],),));}));
  }
}