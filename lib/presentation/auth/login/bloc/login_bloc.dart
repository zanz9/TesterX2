import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLogin>((event, emit) async {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password);

        print('SUCCESS LOGIN');
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          emit(LoginUserNotFound());
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          emit(LoginWrongPassword());
          print('Wrong password provided for that user.');
        }
      }
    });
  }
}
