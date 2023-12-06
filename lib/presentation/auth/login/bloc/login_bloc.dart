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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        AuthService().setUser();
        GetIt.I<AppRouter>().replace(const MainRoute());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          emit(LoginUserNotFound());
        } else if (e.code == 'wrong-password') {
          emit(LoginWrongPassword());
        }
      }
      emit(LoginInitial());
    });

    on<OnAnonymous>(
      (event, emit) async {
        emit(LoginLoading());

        await FirebaseAuth.instance.signInAnonymously();
        AuthService().setUser();
        GetIt.I<AppRouter>().replace(const MainRoute());

        emit(LoginInitial());
      },
    );
  }
}
