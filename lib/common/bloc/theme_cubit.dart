import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  // Method to toggle between light and dark mode
  void updateTheme(ThemeMode themeMode) => emit(themeMode);


  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json ['theme'] as int];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {
      'theme': state.index,
    };
  }

}