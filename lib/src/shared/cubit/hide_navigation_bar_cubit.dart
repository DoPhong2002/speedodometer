import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class HideNavigationBarCubit extends Cubit<bool> {
  HideNavigationBarCubit() : super(true);

  void update(bool value) => emit(value);
}
