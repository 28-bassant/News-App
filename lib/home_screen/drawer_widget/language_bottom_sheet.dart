import 'package:flutter/material.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:news_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return   Container(
      padding: EdgeInsets.symmetric(
        vertical: height * .02
      ),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(32),
        color: AppColors.whiteColor,
      ),
      height: height*.2,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('en');
              setState(() {

              });

            },
            child: languageProvider.appLanguage == 'en' ?
            getSelectedBottomSheet(text: AppLocalizations.of(context)!.english):
            getUnSelectedBottomSheet(text: AppLocalizations.of(context)!.english)
              ,
          ),
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
              languageProvider.changeLanguage('ar');
              setState(() {

              });

            },
            child: languageProvider.appLanguage == 'ar' ?
            getSelectedBottomSheet(text: AppLocalizations.of(context)!.arabic):
            getUnSelectedBottomSheet(text: AppLocalizations.of(context)!.arabic)
            ,
          ),
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
