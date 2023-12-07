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
        await AuthService().register(event.email, event.password);
        await AuthService().login(email: event.email, password: event.password);
        GetIt.I<AppRouter>().replace(const MainRoute());
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          emit(RegisterInvalidEmail());
        } else if (e.code == "missing-password") {
          emit(RegisterMissingPassword());
        } else if (e.code == "email-already-in-use") {
          emit(RegisterEmailAlreadyInUse());
        } else {
          emit(RegisterSomethingElse());
        }
      }
    });
  }
}
