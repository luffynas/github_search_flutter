import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/preference.dart';

part 'theme_state.dart';

enum ThemeModeType { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  Future<void> changeTheme({ThemeModeType? themeModeType}) async {
    if (themeModeType != null) {
      await spUtils.putString('theme', themeModeType.name);
      log('message ::: theme ::1 $themeModeType');
    }

    final themeType = spUtils.getString('theme') ?? '';
    log('message ::: theme :: $themeType');
    switch (themeType) {
      case 'light':
        emit(ThemeLight());
        break;
      case 'dark':
        emit(ThemeDark());
        break;
      default:
        emit(ThemeLight());
    }
  }
}
