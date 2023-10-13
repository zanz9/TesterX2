import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnRegister>((event, emit) async {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(RegisterPasswordWeak());
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          emit(RegisterEmailAlreadyInUse());
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
