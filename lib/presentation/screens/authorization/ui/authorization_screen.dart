import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/presentation/screens/authorization/cubit/authorization_cubit.dart';
import 'package:task_manager/presentation/screens/main/ui/main_screen.dart';
import 'package:task_manager/presentation/screens/path_manager.dart';
import 'package:task_manager/presentation/screens/registration/ui/registration_screen.dart';
import 'package:task_manager/presentation/screens/validator.dart';

class AuthorizationScreen extends StatelessWidget{
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

  static const String ROUTE_NAME = "auth_screen";


  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return BlocBuilder(
        bloc: BlocProvider.of<AuthorizationCubit>(context),
        builder: (context, snapshot){
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child:
            Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Авторизация', style: Theme.of(context).textTheme.headline2),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    Container(
                      child:TextFormField(
                        validator: Validator.validateEmail,
                        controller: emailTextEditingController,
                        style: Theme.of(context).textTheme.headline1,
                        decoration: new InputDecoration(
                          errorStyle: TextStyle(fontSize: 15),
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                          counterStyle: Theme.of(context).textTheme.headline1,
                          labelStyle: Theme.of(context).textTheme.headline1,
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
                        style: Theme.of(context).textTheme.headline1,
                        obscureText: !BlocProvider.of<AuthorizationCubit>(context).state.visiblePassword,
                        decoration: new InputDecoration(
                          errorStyle: TextStyle(fontSize: 15),
                          suffixIcon: IconButton(
                            icon: Icon(BlocProvider.of<AuthorizationCubit>(context).state.visiblePassword ? Icons.visibility_off : Icons.visibility), // Icons.visibility_off
                            color: Theme.of(context).iconTheme.color,
                            onPressed: (){
                              BlocProvider.of<AuthorizationCubit>(context).setVisiblePassword(
                                  !BlocProvider.of<AuthorizationCubit>(context).state.visiblePassword);
                            },
                          ),
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).dividerColor)),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.red)),
                          counterStyle: Theme.of(context).textTheme.headline1,
                          labelStyle: Theme.of(context).textTheme.headline1,
                          labelText: "Пароль",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),),
                        onChanged: (value){},),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    ElevatedButton(onPressed: () async{
                      if(_key.currentState!.validate()
                          && !(BlocProvider.of<AuthorizationCubit>(context).state is LoadingAuthorizationState)){
                        BlocProvider.of<AuthorizationCubit>(context).logIn(
                            emailTextEditingController.text, passwordEditingController.text).then((value){

                          if(BlocProvider.of<AuthorizationCubit>(context).state is DoneAuthorizationState)
                            PathManager.goPage(MainScreen.ROUTE_NAME, context);
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
                      child: Text("Войти", style: Theme.of(context).textTheme.headline1),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).buttonColor,
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05) // put the width and height you want
                      ),),
                    TextButton(child: Text('Регистрация', style: Theme.of(context).textTheme.headline1, ),
                      onPressed: ()=> PathManager.goPage(RegistrationScreen.ROUTE_NAME, context),)
                  ],)),);});
  }
}