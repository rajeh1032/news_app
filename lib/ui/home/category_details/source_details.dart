import 'package:flutter/material.dart';
import 'package:news_app/api/api_manger.dart';
import 'package:news_app/model/my_category.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/ui/home/category_details/source_tab_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';

class SourceDetails extends StatefulWidget {
  SourceDetails({required this.category});
  MyCategory category;
  @override
  State<SourceDetails> createState() => _SourceDetailsState();
}

class _SourceDetailsState extends State<SourceDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
        future: ApiManger.getSources(widget.category.id ?? ""),
        builder: (context, snapshot) {
          //todo:loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.greyColor,
            ));
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
                  ApiManger.getSources(widget.category.id ?? "");
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
                Text(
                  snapshot.data!.message!,
                  style: AppStyles.medium18Black,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ApiManger.getSources(widget.category.id ?? "");
                      });
                    },
                    child: Text(
                      "Try Again",
                      style: AppStyles.medium18Black,
                    ))
              ],
            );
          }
          //todo: 2- server => response successful
          var sourceList = snapshot.data?.sources ?? [];
          return SourceTabWidget(
            sourceList: sourceList,
          );
        });
  }
}
