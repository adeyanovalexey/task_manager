import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/presentation/screens/main/ui/main_screen.dart';
import 'package:task_manager/presentation/screens/path_manager.dart';
import 'package:task_manager/presentation/screens/registration/cubit/registration_cubit.dart';
import 'package:task_manager/presentation/screens/validator.dart';

class RegistrationScreen extends StatelessWidget{
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController surnameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  static const String ROUTE_NAME = "registration_screen";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        bloc: BlocProvider.of<RegistrationCubit>(context),
        builder: (context, snapshot){
          return Form(
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
                    Text('Регистрация', style: Theme.of(context).textTheme.headline2,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    TextFormField(
                      validator: Validator.validateName,
                      controller: nameTextEditingController,
                      style: Theme.of(context).textTheme.headline1,
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
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
                      validator: Validator.validateName,
                      controller: surnameTextEditingController,
                      style: Theme.of(context).textTheme.headline1,
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
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
                      validator: Validator.validateEmail,
                      controller: emailTextEditingController,
                      style: Theme.of(context).textTheme.headline1,
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                        counterStyle: Theme.of(context).textTheme.headline1,
                        labelStyle: Theme.of(context).textTheme.headline1,
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 5.0),
                        ),),
                      onChanged: (value){},),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    TextFormField(
                      validator: Validator.validatePassword,
                      controller: passwordTextEditingController,
                      style: Theme.of(context).textTheme.headline1,
                      decoration: new InputDecoration(
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.white)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                        counterStyle: Theme.of(context).textTheme.headline1,
                        labelStyle: Theme.of(context).textTheme.headline1,
                        labelText: "Пароль",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 5.0),
                        ),),
                      onChanged: (value){},),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    ElevatedButton(
                      onPressed: () async{
                        if(_key.currentState!.validate()){
                          await BlocProvider.of<RegistrationCubit>(context).registration(
                              name: nameTextEditingController.text, surname: surnameTextEditingController.text,  email: emailTextEditingController.text, password: passwordTextEditingController.text
                          );
                          RegistrationState registrationState = BlocProvider.of<RegistrationCubit>(context).state;
                          if(registrationState == RegistrationState.done)
                            PathManager.goPage(MainScreen.ROUTE_NAME, context);
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
                        primary: Theme.of(context).buttonColor,
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                      ),),
                  ],),));});
  }
}