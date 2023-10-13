import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/auth/auth.dart';
import 'package:testerx2/presentation/auth/login/bloc/login_bloc.dart';
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
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: bloc,
      builder: (context, state) {
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
                ),
                const SizedBox(height: 12),
                if (state is LoginWrongPassword)
                  const Text(
                    'Пароль неверный',
                    style: TextStyle(color: Colors.red),
                  ),
                if (state is LoginUserNotFound)
                  const Text(
                    'Пользователь не найден',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 36),
                SignButton(
                  text: 'Войти',
                  onTap: () {
                    bloc.add(
                      OnLogin(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
