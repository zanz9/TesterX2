import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/auth/auth.dart';
import 'package:testerx2/presentation/auth/widgets/mybutton.dart';
import 'package:testerx2/presentation/auth/widgets/mytextfield.dart';

import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  ShakeMe(
                    key: shakeKey,
                    shakeCount: 3,
                    shakeOffset: 10,
                    shakeDuration: const Duration(milliseconds: 500),
                    child: Icon(
                      Icons.lock,
                      color: errorText == 'Добро пожаловать в TesterX'
                          ? Colors.black
                          : Colors.red,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    errorText,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  MyButton(
                    onTap: login,
                  ),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Или продолжить с помощью',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // // google button
                      // SquareTile(imagePath: 'lib/images/google.png'),

                      // SizedBox(width: 25),

                      // // apple button
                      // SquareTile(imagePath: 'lib/images/apple.png')
                    ],
                  ),

                  const SizedBox(height: 50),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
