import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Layout/Cubit/cubit_cubit.dart';
import 'package:newsapp/Layout/Cubit/cubit_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:newsapp/Modules/WebView/Web_View.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context).business;
        return bodyBuilder(cubit,state);
      },
    );
  }

}
Widget bodyBuilder(cubit,state){
  return ConditionalBuilder(
    builder: (BuildContext context) {
      return ListView(
        children: List.generate(cubit.length, (index) {
          return getCard(cubit[index],context);
        }),
      );
    },
    condition: state is! NewsGetBusinessLoadingState,
    fallback: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
Widget getCard(business,context) {
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewScreen(
        url: business['url'],
      )));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(business['urlToImage'].toString()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 110,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        business['title'].toString(),
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    business['publishedAt'].toString(),
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}