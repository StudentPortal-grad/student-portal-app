import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/utils/service_locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Authenticated()); // Assume user starts as logged in
  final AuthRepository authRepository = getIt<AuthRepository>();

  void logout() async {
    emit(LoggingOut());
    var response = await authRepository.logout();
    response.fold(
      (failure) {
        emit(Unauthenticated(message: failure.message)); // Handle failure
      },
      (r) {
        emit(Unauthenticated(message: r)); // Change state to logged out
      },
    );
  }
}
