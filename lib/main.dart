import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/Layout/Cubit/cubit_cubit.dart';
import 'package:newsapp/Layout/Cubit/cubit_state.dart';
import 'package:newsapp/Layout/News_Layout.dart';
import 'package:newsapp/Network/Cashe_Helper.dart';
import 'package:newsapp/Network/dio_helper.dart';
import 'package:newsapp/bloc_observer.dart';
import 'package:bloc/bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () {
      NewsCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CasheHelper.init();

  dynamic modee = CasheHelper.getData(key: 'isDark');
  runApp(MyApp(mode: modee,));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.mode}) : super(key: key);

  dynamic mode ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      NewsCubit()
        ..getBusiness()
        ..getScience()
        ..getSports()..changeAppMode(fromCashe: mode),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1
                  ),
                )
            ),
            darkTheme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1
                  ),
                )
            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
