import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/features/auth/presentation/widgets/login_body.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../manager/login_bloc/login_bloc.dart';
import '../manager/login_bloc/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LogInFailure){
              CustomToast(context).showErrorToast(message: state.error);
            }
            if(state is LogInSuccess){
              CustomToast(context).showSuccessToast(message: 'Login Successfully');
              AppRouter.clearAndNavigate(AppRouter.homeView);
            }
          },
          builder: (context, state) {
            return PopScope(
              canPop: false,
              child: LoginBody(),
            );
          },
        ),
      ),
    );
  }
}
