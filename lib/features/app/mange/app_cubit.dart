import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  int homeIndex = 0,
      physicalInfoIndex = 0,
      accountInfoIndex = 0,
      inbodyIndex = 0;

  PageController homeController = PageController();
  PageController physicalInfoController = PageController();
  PageController accountInfoController = PageController();
  PageController inbodyController = PageController();

  void onHomeToggle(int value) async {
    homeIndex = value;
    emit(SetState());
  }

  void onEditPhysicalInfoToggle(int value) async {
    physicalInfoIndex = value;
    emit(SetState());
  }

  void onEditAccountInfoToggle(int value) async {
    accountInfoIndex = value;
    emit(SetState());
  }

  void onInbodyToggle(int value) async {
    inbodyIndex = value;
    emit(SetState());
  }

  @override
  Future<void> close() {
    homeController.dispose();
    physicalInfoController.dispose();
    accountInfoController.dispose();
    inbodyController.dispose();
    homeIndex = 0;
    physicalInfoIndex = 0;
    accountInfoIndex = 0;
    inbodyIndex = 0;
    return super.close();
  }
}
