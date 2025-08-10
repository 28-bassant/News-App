import 'package:flutter/material.dart';
import 'package:news_app/api/models/category.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  int index;
  Category category;
   CategoryItem({super.key,required this.index,required this.category});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: (index % 2 == 0)? Alignment.bottomRight :Alignment.bottomLeft,
      children: [
        ClipRRect(
          child: Image(image: AssetImage(category.image)),
          borderRadius: BorderRadiusGeometry.circular(24),
        ),
        Container(

          width: width * .4,
          margin: EdgeInsets.symmetric(
            vertical: height * .02,
            horizontal: width * .02
          ),
          padding: EdgeInsetsGeometry.directional(
            start: (index%2 == 0) ? width * .03: 0,
            end: (index%2 == 0) ?0 : width * .03,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(84),
            color: AppColors.greyColor
          ),
          child: Row(
            textDirection: (index%2 == 0) ? TextDirection.ltr : TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('View All' , style: Theme.of(context).textTheme.headlineMedium,),
              CircleAvatar(

                backgroundColor: Theme.of(context).primaryColor,
                child: Icon((index%2 == 0) ?Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_rounded,color: Theme.of(context).indicatorColor,),
              )
            ],
          ),
        )
      ],
    );
  }
}
