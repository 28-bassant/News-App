import 'package:flutter/material.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:news_app/l10n/app_localizations.dart';
import '../../providers/app_theme_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return  Container(

      padding: EdgeInsets.symmetric(
          vertical: height * .02
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
        color: AppColors.whiteColor,
      ),
      height: height*.2,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
              setState(() {

              });
            },
              child: themeProvider.isDark()? getSelectedBottomSheet(text:AppLocalizations.of(context)!.dark):
              getUnSelectedBottomSheet(text: AppLocalizations.of(context)!.dark)),
          SizedBox(height: height*.01,),
          Divider(
            height: height * .01,
            indent: width * .04,
            endIndent: width * .04,
            color: AppColors.blackColor,
            thickness: 2,
          ),
          SizedBox(
            height: height * .02,
          ),
          InkWell(
              onTap: () {
                themeProvider.changeTheme(ThemeMode.light);
                setState(() {

                });
              },
              child: !themeProvider.isDark()?
    getSelectedBottomSheet(text: AppLocalizations.of(context)!.light):
    getUnSelectedBottomSheet(text: AppLocalizations.of(context)!.light),)
        ],
      ),
    );
  }
  Widget getSelectedBottomSheet({required String text}){
    return
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 4,horizontal: 16
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.blackColor,

          ),
          child: Text(text,style: AppStyles.medium20White,),
        );
  }
  Widget getUnSelectedBottomSheet({required String text}){
    return
      Text(text,style: AppStyles.medium20Black,);
  }
}
