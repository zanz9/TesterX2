import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:testerx2/presentation/auth/auth.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = LoginBloc();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final shakeKey = GlobalKey<ShakeWidgetState>();

    login() {
      bloc.add(
        OnLogin(
          email: emailController.text,
          password: passwordController.text,
          shakeKey: shakeKey,
        ),
      );
    }

    return BlocBuilder<LoginBloc, LoginState>(
      bloc: bloc,
      builder: (context, state) {
        String errorText = 'Добро пожаловать в TesterX';
        if (state.runtimeType == LoginWrongPassword ||
            state.runtimeType == LoginUserNotFound) {
          errorText = 'Введенные данные некоректны';
        } else if (state.runtimeType == LoginConnectionWrong) {
          errorText = 'Соединение с сервером потеряна';
        } else if (state.runtimeType == LoginSomethingElse) {
          errorText = 'Что-то пошло не так';
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LockIconWithAnimation(
                      shakeKey: shakeKey,
                      color: errorText == 'Добро пожаловать в TesterX'
                          ? Colors.black
                          : Colors.red,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 25),
                    EmailInput(
                        emailController: emailController, onSubmitted: login),
                    const SizedBox(height: 10),
                    PasswordInput(
                      passwordController: passwordController,
                      onSubmitted: login,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              context.router.push(const ForgetPasswordRoute()),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Text(
                              'Забыли пароль?',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                        onTap: login,
                        onTapOutside: () {
                          errorText = 'Добро пожаловать в TesterX';
                          bloc.add(OnUpdateLogin());
                        },
                        isLoading: state is LoginLoading,
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Еще не зарегистрованы?',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () =>
                              context.router.replace(const RegisterRoute()),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Зарегистрироваться',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
