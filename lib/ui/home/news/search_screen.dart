import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/widget/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.04),
      child: Column(
        children: [
          SizedBox(
              height: height * 0.1,
              width: double.infinity,
              child: CustomTextField(
                suffixIcon: Icon(
                    size: 25,
                    color: Theme.of(context).indicatorColor,
                    Icons.search),
                onChanged: (data) async {
                  var response = await ApiManger.getNewsBySourceId(
                      sourceId: 'ABC News', query: data);
          
                },
              )),
          // Expanded(child: )
        ],
      ),
    ));
  }
}
