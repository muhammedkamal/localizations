import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  // Passing an initial value (state) with a default 'Locale' to the super class.
  LocaleCubit() : super(SelectedLocale(Locale('en')));

  // Once we call this method, the BlocBuilder<LocaleCubit>
  // in the 'main.dart' will rebuild the entire app with
  // the new emitted state that holds the 'ar' locale.
  void toArabic() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("locale", "ar");
    emit(SelectedLocale(Locale('ar')));
  }

  // Same as the previous method, but with the 'en' locale.
  void toEnglish() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("locale", "en");
    emit(SelectedLocale(Locale('en')));
  }
}
