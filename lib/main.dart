import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/api/models/SourceResponse.dart';
import 'package:news_app/api/models/category.dart';
import 'package:news_app/home_screen/home_screen.dart';
import 'package:news_app/home_screen/search_screen/search_screen.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/utils/app_routes.dart';
import 'package:news_app/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:news_app/l10n/app_localizations.dart';

void main(){
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
        ChangeNotifierProvider(create: (context) => AppThemeProvider(),),

      ],

      child: MyApp()));

}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);


    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName : (context) => HomeScreen(),
        AppRoutes.searchRouteName : (context) => SearchScreen(source: Source(),),
      },
      themeMode:themeProvider.appTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: Locale(languageProvider.appLanguage),
    );
  }
}