import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  int homeIndex = 0;
  PageController homeController = PageController();

  void onHomeToggle(int value) {
    homeIndex = value;
    emit(AppUpdated()); // Emit new state
  }

  // void reset() {
  //   homeIndex = 0;
  //   homeController.jumpToPage(0); // Reset to the first page if needed
  // }

  @override
  Future<void> close() {
    homeController.dispose();
    return super.close();
  }
}
