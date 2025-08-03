import 'package:flutter/material.dart';
import 'package:news_app/home_screen/drawer_widget/drawer_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/l10n/app_localizations.dart';

import '../utils/app_assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home,style: Theme.of(context).textTheme.headlineLarge,),

      ),
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: DrawerWidget()
      ),

    );
  }
}
