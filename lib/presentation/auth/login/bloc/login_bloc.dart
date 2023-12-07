import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/utils/firestore/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        await AuthService().login(email: event.email, password: event.password);
        GetIt.I<AppRouter>().replace(const MainRoute());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(LoginUserNotFound());
        } else if (e.code == "invalid-login-credentials") {
          emit(LoginWrongPassword());
        } else if (e.code == "network-request-failed") {
          emit(LoginConnectionWrong());
        } else {
          emit(LoginSomethingElse());
        }
      }
    });

    on<OnAnonymous>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          await AuthService().login();
          GetIt.I<AppRouter>().replace(const MainRoute());
        } on FirebaseAuthException catch (e) {
          if (e.code == "network-request-failed") {
            emit(LoginConnectionWrong());
          } else {
            emit(LoginSomethingElse());
          }
        }
      },
    );
  }
}
