import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/home/news/news_item.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class NewsWidget extends StatefulWidget {
  NewsWidget({required this.source});

  Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.getNewsBySourceId(widget.source.id ?? ""),
        builder: (context, snapshot) {
          //todo:if is loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
            );
          }
          //todo: error client

          else if (snapshot.hasError) {
            Text(
              "SomeThing went wrong",
              style: AppStyles.medium18Black,
            );
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ApiManger.getNewsBySourceId(widget.source.id ?? "");
                });
              },
              child: Text(
                "Try Again",
                style: AppStyles.medium18Black,
              ),
            );
          }

          //todo: server => response (success , error)?
          //todo: 1- server => response error

          if (snapshot.data?.status != 'ok') {
            return Column(
              children: [
                Text(snapshot.data!.message!,
                    style: Theme.of(context).textTheme.headlineLarge),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ApiManger.getNewsBySourceId(widget.source.id ?? "");
                      });
                    },
                    child: Text(
                      "Try Again",
                      style: AppStyles.medium18Black,
                    ))
              ],
            );
          }

          var newsList = snapshot.data?.articles ?? [];
          return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
              });
        });
  }
}
