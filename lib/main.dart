import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/presentation/app_routes_helper.dart';
import 'package:task_manager/presentation/screens/app_cubit.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  MyApp myApp = await MyApp.getInstance();
  runApp(myApp);
}

class MyApp extends StatelessWidget {

  final AppCubit appCubit;
  MyApp({required this.appCubit});

  static Future<MyApp> getInstance() async{
    AppCubit appCubit = AppCubit();
    await appCubit.init();
    return MyApp(appCubit: appCubit);
  }

  @override
  StatelessElement createElement() {
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => appCubit,
        child: BlocBuilder<AppCubit, AppCubitState>(builder:(context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Color(0xFF3D5AFE),
              backgroundColor: Color(0xFF4FC3F7),
              buttonColor: Color(0xFFEC407A),
              dividerColor: Colors.white70,
              primarySwatch: Colors.blue,
              cardColor: Color(0xFF00796B),
              iconTheme: IconThemeData(color: Colors.white),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Color(0xFFD81B60),
                  unselectedItemColor: Color(0xFF1565C0)),
              textTheme: TextTheme(headline1: TextStyle(color: Colors.white, fontSize: 17,
                  fontWeight: FontWeight.w400, decorationStyle: TextDecorationStyle.wavy),
                headline2: TextStyle(color: Colors.white, fontSize: 25,
                    fontWeight: FontWeight.w400, decorationStyle: TextDecorationStyle.wavy)
              ),

            ),
            //home: MainScreen(appCubit.app != null ? true : false),
           // routes: {TaskManager.homePath: (context) => MainScreen(appCubit.app != null ? true : false)},
            initialRoute: AppRoutesHelper.getRoute(appCubit.app != null),
            onGenerateRoute: (settings) => AppRoutesHelper.onGenerateRoute(settings),
          );
        })
    );
  }
}