import 'package:flutter/material.dart';
import 'package:news_app/home_screen/drawer_widget/language_bottom_sheet.dart';
import 'package:news_app/home_screen/drawer_widget/theme_bottom_sheet.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:provider/provider.dart';
import 'package:news_app/l10n/app_localizations.dart';
import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Column(
      children: [
        Container(
          color: AppColors.whiteColor,
          height: height * .2,
          child: Center(child: Text(AppLocalizations.of(context)!.news_app, style: AppStyles.bold24Black)),
        ),
        SizedBox(height: height * .02),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              ImageIcon(
                AssetImage(AppAssets.homeIcon),
                color: AppColors.whiteColor,
                size: 40,
              ),
              SizedBox(width: width * .02),
              Text(AppLocalizations.of(context)!.go_to_home, style: AppStyles.bold20White),
            ],
          ),
        ),
        SizedBox(height: height * .02),
        Divider(
          height: height * .01,
          indent: width * .04,
          endIndent: width * .04,
          color: AppColors.whiteColor,
          thickness: 1,
        ),
        SizedBox(height: height * .02),
        Row(
          children: [
            ImageIcon(
              AssetImage(AppAssets.themeIcon),
              color: AppColors.whiteColor,
              size: 40,
            ),
            SizedBox(width: width * .02),
            Text(AppLocalizations.of(context)!.theme, style: AppStyles.bold20White),
          ],
        ),

        InkWell(
          onTap: () => showThemeBottomSheet(),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: height * .02,
              horizontal: width * .02,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .01,
            ),

            decoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                themeProvider.isDark()?
                Text(AppLocalizations.of(context)!.dark, style: AppStyles.medium20White):
                Text(AppLocalizations.of(context)!.light, style: AppStyles.medium20White),
                Spacer(),
                ImageIcon(
                  AssetImage(AppAssets.arrowIcon),
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * .02),
        Divider(
          height: height * .01,
          indent: width * .04,
          endIndent: width * .04,
          color: AppColors.whiteColor,
          thickness: 2,
        ),
        SizedBox(height: height * .02),
        Row(
          children: [
            ImageIcon(
              AssetImage(AppAssets.languageIcon),
              color: AppColors.whiteColor,
              size: 40,
            ),
            SizedBox(width: width * .02),
            Text(AppLocalizations.of(context)!.language, style: AppStyles.bold20White),
          ],
        ),

        InkWell(
          onTap: () => showLanguageBottomSheet(),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: height * .02,
              horizontal: width * .02,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .01,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.whiteColor, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                languageProvider.appLanguage == 'en'?
                Text(AppLocalizations.of(context)!.english, style: AppStyles.medium20White):
                Text(AppLocalizations.of(context)!.arabic, style: AppStyles.medium20White),
                Spacer(),
                ImageIcon(
                  AssetImage(AppAssets.arrowIcon),
                  color: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }
  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
