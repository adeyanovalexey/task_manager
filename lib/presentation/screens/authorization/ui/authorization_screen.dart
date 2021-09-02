import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/presentation/screens/authorization/cubit/authorization_cubit.dart';
import 'package:task_manager/presentation/screens/validator.dart';
import 'package:task_manager/task_manager.dart';

class AuthorizationScreen extends StatelessWidget{
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return BlocProvider(
        create: (_) => AuthorizationCubit.instance,
        child: BlocBuilder(
            bloc:   AuthorizationCubit.instance,
            builder: (context, snapshot){
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightGreenAccent,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child:
                Form(
                    key: _key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child:TextFormField(
                            validator: Validator.validateEmail,
                            controller: emailTextEditingController,
                            decoration: new InputDecoration(
                              errorStyle: TextStyle(fontSize: 15),
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
                          // color: Colors.white,
                          child:TextFormField(
                            controller: passwordEditingController,
                            validator: Validator.validatePassword,
                            //autofocus: true,
                            obscureText: !BlocProvider.of<AuthorizationCubit>(context).state.visiblePassword,
                            decoration: new InputDecoration(
                              errorStyle: TextStyle(fontSize: 15),
                              suffixIcon: IconButton(
                                icon: Icon(BlocProvider.of<AuthorizationCubit>(context).state.visiblePassword ? Icons.visibility_off : Icons.visibility), // Icons.visibility_off
                                onPressed: (){
                                  BlocProvider.of<AuthorizationCubit>(context).setVisiblePassword(
                                      !BlocProvider.of<AuthorizationCubit>(context).state.visiblePassword);
                                },
                              ),
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
                        ElevatedButton(onPressed: () async{
                          if(_key.currentState!.validate()){
                            BlocProvider.of<AuthorizationCubit>(context).logIn(
                                emailTextEditingController.text, passwordEditingController.text).then((value){

                              if(BlocProvider.of<AuthorizationCubit>(context).state is DoneAuthorizationState)
                                TaskManager.goPage(TaskManager.homePath, context);
                              else
                                Fluttertoast.showToast(
                                    msg: "Не верный логин или пароль",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                            });
                          }
                        },
                          child: Text("Войти"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                          ),),
                        TextButton(child: Text('Регистрация', style: TextStyle(fontSize: 17, color: Colors.blue, ), ),
                          onPressed: ()=> TaskManager.goPage(TaskManager.registrationPath, context),)
                      ],)),);}));
  }
}