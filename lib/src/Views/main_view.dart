import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Blocs/blocs.dart';
import '../Localization/app_localizations.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    getLocale();
    super.initState();
  }

  Future<void> getLocale() async {
    String locale = 'en';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.containsKey('locale')
        ? locale = prefs.getString('locale')
        : prefs.setString('locale', 'en');
    locale == 'en'
        ? BlocProvider.of<LocaleCubit>(context).toEnglish()
        : BlocProvider.of<LocaleCubit>(context).toArabic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('app_bar_title')),
      leading: IconButton(
        icon: Icon(Icons.translate),
        onPressed: () {
          if (AppLocalizations.of(context).isEnLocale) {
            BlocProvider.of<LocaleCubit>(context).toArabic();
          } else {
            BlocProvider.of<LocaleCubit>(context).toEnglish();
          }
        },
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('head_title'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
