import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/utils/utils.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnRegister>((event, emit) async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        AuthService().setUser();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(RegisterPasswordWeak());
        } else if (e.code == 'email-already-in-use') {
          emit(RegisterEmailAlreadyInUse());
        }
      }
    });
  }
}
