import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/auth/auth.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = RegisterBloc();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordController2 = TextEditingController();

    register() {
      if (passwordController.text == passwordController2.text) {
        bloc.add(OnRegister(
          email: emailController.text,
          password: passwordController.text,
        ));
      }
    }

    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: bloc,
      builder: (context, state) {
        String errorText = '';
        switch (state.runtimeType) {
          case RegisterInvalidEmail:
          case RegisterMissingPassword:
            errorText = 'Введенные данные некоректны';
            break;
          case RegisterEmailAlreadyInUse:
            errorText = 'Этот Email уже используется';
            break;
          case RegisterSomethingElse:
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
                  'Регистрация',
                  style: theme.textTheme.headlineLarge?.copyWith(fontSize: 60),
                ),
                const SizedBox(height: 40),
                EmailInput(
                  labelHide: true,
                  controller: emailController,
                ),
                const SizedBox(height: 24),
                PasswordInput(
                  labelHide: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 24),
                PasswordInput(
                  isSecond: true,
                  labelHide: true,
                  controller: passwordController2,
                  onSubmitted: (value) {
                    register();
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 36),
                SignButton(
                  loading: state is RegisterLoading,
                  text: 'Зарегистрироваться',
                  onTap: register,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('-'),
                ),
                GestureDetector(
                  onTap: () {
                    context.router.replace(const LoginRoute());
                  },
                  child: const Text('Уже зарегистрировались? Войти'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
