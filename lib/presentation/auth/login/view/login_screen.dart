import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/auth/auth.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = LoginBloc();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    login() {
      bloc.add(
        OnLogin(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }

    return BlocBuilder<LoginBloc, LoginState>(
      bloc: bloc,
      builder: (context, state) {
        String errorText = '';
        switch (state.runtimeType) {
          case LoginWrongPassword:
          case LoginUserNotFound:
            errorText = 'Введенные данные некоректны';
            break;
          case LoginConnectionWrong:
            errorText = 'Соединение с сервером потеряна';
            break;
          case LoginSomethingElse:
            errorText = 'Что-то пошло не так';
            break;
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Вход',
                  style: theme.textTheme.headlineLarge?.copyWith(fontSize: 60),
                ),
                const SizedBox(height: 28),
                EmailInput(
                  labelHide: true,
                  controller: emailController,
                ),
                const SizedBox(height: 24),
                PasswordInput(
                  labelHide: true,
                  controller: passwordController,
                  onSubmitted: (value) {
                    login();
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 36),
                SignButton(
                  loading: state is LoginLoading,
                  text: 'Войти',
                  onTap: login,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('-'),
                ),
                GestureDetector(
                  onTap: () {
                    context.router.replace(const RegisterRoute());
                  },
                  child: const Text('Нет аккаунта? Зарегистрироваться'),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    bloc.add(OnAnonymous());
                  },
                  child: const Text('Войти анонимно'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
