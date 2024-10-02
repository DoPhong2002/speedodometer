import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/local/shared_preferences_manager.dart';

@singleton
class ThemeCubit extends HydratedCubit<int> {
  ThemeCubit() : super(0) {
    _initState();
  }

  Future<void> _initState() async {
    emit(await PreferenceManager.getThemeOdometer());
  }

  Future<void> changeTheme(int value) async {
    if (value != state) {
      emit(value);
    }
  }

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['theme'] as int;
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return {'theme': state};
  }
}
