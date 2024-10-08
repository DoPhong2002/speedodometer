import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class BottomTabCubit extends Cubit<int> {
  BottomTabCubit() : super(0);

  void changeTab(int tabIndex) => emit(tabIndex);
}
