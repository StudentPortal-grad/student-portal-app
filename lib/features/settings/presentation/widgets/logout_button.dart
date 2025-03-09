import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/custom_toast.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../app/manager/auth_cubit/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoggingOutFailed) {
          CustomToast(context).showErrorToast(message: state.message);
        }
        if (state is Unauthenticated) {
          CustomToast(context).showErrorToast(message: state.message);
          AppRouter.clearAndNavigate(AppRouter.loginView);
        }
      },
      builder: (context, state) {
        return CustomAppButton(
          label: "Sign Out",
          loading: state is LoggingOut,
          onTap: () => context.read<AuthCubit>().logout(),
          backgroundColor: Colors.white,
          textStyle:
              Styles.font15w600.copyWith(color: ColorsManager.orangeColor),
        );
      },
    );
  }
}
