import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../api/models/NewsResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBottomSheet extends StatefulWidget {
  News news;
   NewsBottomSheet({super.key,required this.news});

  @override
  State<NewsBottomSheet> createState() => _NewsBottomSheetState();
}

class _NewsBottomSheetState extends State<NewsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      height: height * .54,
      padding: EdgeInsets.symmetric(
          vertical: height * .02,
          horizontal: width * .02
      ),
      decoration: BoxDecoration(
          color: Theme
              .of(context)
              .indicatorColor,
          borderRadius: BorderRadius.circular(8)
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
          SizedBox(height: height * .02,),
          Text(widget.news.content ?? '', style: Theme
              .of(context)
              .textTheme
              .bodyMedium,),
          SizedBox(height: height * .02,),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme
                      .of(context)
                      .primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: height * .02,
                      horizontal: width * .02
                  ),

                ),
                onPressed: () {
                  launch(widget.news.url ?? '', isNewTab: true);
                },

                child: Text('View Full Articel', style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge,)),
          )
        ],
      ),
    );
  }
}

Future<void> launch(String url, {bool isNewTab = true}) async {
  await launchUrl(
    Uri.parse(url),
    webOnlyWindowName: isNewTab ? '_blank' : '_self',
  );
}
