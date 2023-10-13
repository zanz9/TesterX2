import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/auth/auth.dart';
import 'package:testerx2/presentation/auth/register/bloc/register_bloc.dart';
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: bloc,
      builder: (context, state) {
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
                // const SizedBox(height: 24),
                // const PasswordInput(
                //   labelHide: true,
                //   isSecond: true,
                // ),
                const SizedBox(height: 48),
                SignButton(
                  text: 'Зарегистрироваться',
                  onTap: () {
                    bloc.add(OnRegister(
                      email: emailController.text,
                      password: passwordController.text,
                    ));
                  },
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
