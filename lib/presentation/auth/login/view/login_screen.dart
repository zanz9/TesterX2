import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/presentation/auth/auth.dart';

import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:testerx2/router/router.dart';

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
          body: Center(
            child: SingleChildScrollView(
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
                  PrimaryInput(
                    controller: emailController,
                    hintText: 'Почта',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  PrimaryInput(
                    controller: passwordController,
                    hintText: 'Пароль',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              context.router.push(const ForgetPasswordRoute()),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              'Забыли пароль?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  PrimaryButton(
                    text: 'Войти',
                    isLoading: state.runtimeType == LoginLoading,
                    onTap: login,
                    onTapOutside: () {
                      errorText = 'Добро пожаловать в TesterX';
                      bloc.add(OnUpdateLogin());
                    },
                  ),

                  const SizedBox(height: 50),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Divider(
                  //           thickness: 0.5,
                  //           color: Colors.grey[400],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //         child: Text(
                  //           'Или продолжить с помощью',
                  //           style: TextStyle(color: Colors.grey[700]),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Divider(
                  //           thickness: 0.5,
                  //           color: Colors.grey[400],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // const SizedBox(height: 50),

                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  // SquareTile(
                  //   imagePath: 'images/icons/user.png',
                  //   onTap: () {
                  //     bloc.add(OnAnonymous());
                  //   },
                  // ),
                  // SizedBox(width: 25),
                  // SquareTile(imagePath: 'images/icons/google.png'),
                  // const SizedBox(width: 25),
                  // const SquareTile(imagePath: 'images/icons/apple.png')
                  //   ],
                  // ),

                  // const SizedBox(height: 50),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Еще не зарегистрованы?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () =>
                            context.router.replaceAll([const RegisterRoute()]),
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
