import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/utils/utils.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnRegister>((event, emit) async {
      emit(RegisterLoading());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        AuthService().setUser();
        GetIt.I<AppRouter>().replace(const MainRoute());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(RegisterPasswordWeak());
        } else if (e.code == 'email-already-in-use') {
          emit(RegisterEmailAlreadyInUse());
        }
      }
      emit(RegisterInitial());
    });
  }
}
