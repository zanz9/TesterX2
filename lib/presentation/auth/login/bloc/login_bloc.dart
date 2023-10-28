import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/auth/models/user.dart';
import 'package:testerx2/utils/firestore/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLogin>((event, emit) async {
      try {
        final data = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        final user = CustomUser(uid: data.user!.uid);
        AuthService().setUser(user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          emit(LoginUserNotFound());
        } else if (e.code == 'wrong-password') {
          emit(LoginWrongPassword());
        }
      }
    });
  }
}
