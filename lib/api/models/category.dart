import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:provider/provider.dart';

class Category{
  String id;
  String title;
  String image;
  Category({
    required this.id,
    required this.title,
    required this.image
});

  static List<Category> getCategoryList(AppThemeProvider themeProvider){
   return [
     Category(id: 'general',
         title: 'General',
         image:themeProvider.isDark()? AppAssets.generalLightImage : AppAssets.generalDarkImage),
     Category(id: 'business',
         title: 'Business',
         image:themeProvider.isDark()? AppAssets.businessLightImage : AppAssets.businessDarkImage),
     Category(id: 'sports',
         title: 'Sports',
         image:themeProvider.isDark()? AppAssets.sportsLightImage : AppAssets.sportsDarkImage),
     Category(id: 'technology',
         title: 'Technology',
         image:themeProvider.isDark()? AppAssets.technologyLightImage : AppAssets.technologyDarkImage),
     Category(id: 'science',
         title: 'Science',
         image:themeProvider.isDark()? AppAssets.scienceLightImage : AppAssets.scienceDarkImage),
     Category(id: 'health',
         title: 'Health',
         image:themeProvider.isDark()? AppAssets.healthLightImage : AppAssets.healthDarkImage),
     Category(id: 'entertainment',
         title: 'Entertainment',
         image:themeProvider.isDark()? AppAssets.entertainmentLightImage : AppAssets.entertainmentDarkImage),


   ];
  }
}