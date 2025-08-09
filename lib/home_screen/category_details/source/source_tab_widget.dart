import 'package:flutter/material.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/home_screen/category_details/news/news_widget.dart';
import 'package:news_app/home_screen/category_details/source/source_name.dart';
import 'package:news_app/utils/app_colors.dart';

class SourceTabWidget extends StatefulWidget {
  List<Source> sourceList ;

   SourceTabWidget({super.key,required this.sourceList});

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return DefaultTabController(

        length: widget.sourceList.length,
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                selectedIndex = index;
                setState(() {
            
                });
              },
              isScrollable: true,
                indicatorColor: Theme.of(context).indicatorColor,
                dividerColor: AppColors.transparentColor,
                tabAlignment: TabAlignment.start,
                tabs: widget.sourceList.map( (source) {
                  return SourceName(sources: source,
                      isSelected: selectedIndex == widget.sourceList.indexOf(source));
                },).toList()
            ),
            SizedBox(height: height * .02,),
            Expanded(child: NewsWidget(source: widget.sourceList[selectedIndex]))
          ],
        )
    );
  }
}
