import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:testerx2/features/auth/auth.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = RegisterBloc();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordController2 = TextEditingController();
    final shakeKey = GlobalKey<ShakeWidgetState>();

    register() {
      bloc.add(OnRegister(
        email: emailController.text,
        password: passwordController.text,
        password2: passwordController2.text,
        shakeKey: shakeKey,
      ));
    }

    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: bloc,
      builder: (context, state) {
        String errorText = 'Добро пожаловать в TesterX';
        if (state.runtimeType == RegisterInvalidEmail) {
          errorText = 'Введенные данные некоректны';
        } else if (state.runtimeType == RegisterWeakPassword) {
          errorText = 'Пароль слишком слабый';
        } else if (state.runtimeType == RegisterMissingPassword) {
          errorText = 'Введите пароль';
        } else if (state.runtimeType == RegisterEmailAlreadyInUse) {
          errorText = 'Почта уже используется';
        } else if (state.runtimeType == RegisterSomethingElse) {
          errorText = 'Что-то пошло не так';
        } else if (state.runtimeType == RegisterPasswordNotTheSame) {
          errorText = 'Пароли не совпадают';
        }
        return Scaffold(
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
                      emailController: emailController,
                      onSubmitted: register,
                    ),
                    const SizedBox(height: 10),
                    PasswordInput(
                      passwordController: passwordController,
                      onSubmitted: register,
                    ),
                    const SizedBox(height: 10),
                    PasswordInput(
                      passwordController: passwordController2,
                      isSecond: true,
                      onSubmitted: register,
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                        onTap: register,
                        onTapOutside: () {
                          errorText = 'Добро пожаловать в TesterX';
                          bloc.add(OnUpdateRegister());
                        },
                        isLoading: state is RegisterLoading,
                        child: const Text(
                          'Зарегистрироваться',
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
                          'Уже есть аккаунт?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () =>
                              context.router.replaceAll([const LoginRoute()]),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Войти',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
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
