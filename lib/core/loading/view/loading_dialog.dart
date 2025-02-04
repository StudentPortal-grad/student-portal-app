import 'package:flutter/material.dart';

import '../../utils/app_router.dart';
import 'loading_view.dart';

class LoadingDialog {
  static bool isShown = false;

  static void showLoadingDialog(BuildContext context) {
    if (!isShown) {
      isShown = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        builder: (BuildContext context) {
          return const PopScope(
            canPop: false,
            child: Center(
              child: LoadingView(),
            ),
          );
        },
      );
    }
  }

  static void hideLoadingDialog() {
    if (isShown) {
      isShown = false;
      AppRouter.router.pop();
    }
  }
}
