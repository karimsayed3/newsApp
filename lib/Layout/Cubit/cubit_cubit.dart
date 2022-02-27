import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Layout/Cubit/cubit_state.dart';
import 'package:newsapp/Modules/Business/Business_Screen.dart';
import 'package:newsapp/Modules/Science/Science_Screen.dart';
import 'package:newsapp/Modules/Sports/Sports_Screen.dart';
import 'package:newsapp/Network/Cashe_Helper.dart';
import 'package:newsapp/Network/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void changeBottomNavBar(index){
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];


  List<dynamic> business = [];

  getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country' : 'eg',
      'category' : 'business',
      'apiKey' : '26a7115ffa5548eaad50da7ee33a29ae'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  getSports(){    emit(NewsGetSportsLoadingState());
  DioHelper.getData(path: 'v2/top-headlines', query: {
    'country' : 'eg',
    'category' : 'sports',
    'apiKey' : '26a7115ffa5548eaad50da7ee33a29ae'
  }).then((value) {
    // print(value.data['articles'][0]['title']);
    sports = value.data['articles'];
    emit(NewsGetSportsSuccessState());
  }).catchError((error){
    emit(NewsGetSportsErrorState(error.toString()));
  });
  }



  List<dynamic> science = [];

  getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country' : 'eg',
      'category' : 'science',
      'apiKey' : '26a7115ffa5548eaad50da7ee33a29ae'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }
  List<dynamic> search = [];

  getSearch({required String text}){
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(path: 'v2/everything', query: {
      'q' : '$text',
      'apiKey' : '26a7115ffa5548eaad50da7ee33a29ae'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }


  bool isDark = false;

  changeAppMode({dynamic fromCashe}){
    if(fromCashe != null){
      isDark = fromCashe;
      emit(NewsChangeModeState());
    }
    else {
      isDark = !isDark;
      CasheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }
  }
}
