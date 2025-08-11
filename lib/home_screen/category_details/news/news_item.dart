import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/models/NewsResponse.dart';
import 'package:news_app/home_screen/category_details/news/news_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatefulWidget {
  News news;
  NewsItem({super.key, required this.news});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.parse(widget.news.publishedAt ?? '');

    return InkWell(
      onTap: () {
       showNewsBottomSheet(context);
       setState(() {

       });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * .02,
          vertical: height * .01,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: width * .04,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Theme.of(context).indicatorColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: widget.news.urlToImage ?? '',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            SizedBox(height: height * .02),
            Text(widget.news.title ?? '', style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: height * .02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'By : ${widget.news.author ?? ''}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),

                Text(
                  timeago.format(dateTime),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showNewsBottomSheet(BuildContext context){
    showBottomSheet(
        context: context,
        builder: (context) => NewsBottomSheet(news: widget.news),);
  }
}
