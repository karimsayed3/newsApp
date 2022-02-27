import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Layout/Cubit/cubit_cubit.dart';
import 'package:newsapp/Layout/Cubit/cubit_state.dart';
import 'package:newsapp/Modules/Business/Business_Screen.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var search = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "search must not be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Search'),
                    prefix: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(text: value);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: bodyBuilder(search, context))
              ],
            ),
          ),
        );
      },
    );
  }
}
