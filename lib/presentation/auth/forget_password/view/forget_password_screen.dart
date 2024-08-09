import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_view/gif_view.dart';
import 'package:testerx2/presentation/auth/auth.dart';

@RoutePage()
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ForgetPasswordBloc();
    final TextEditingController emailController = TextEditingController();

    String errorText =
        'Напишите вашу почту, чтобы мы могли отправить ссылку на сброс пароля';

    GifController gifController = GifController(
      autoPlay: false,
      loop: false,
      inverted: false,
    );

    send() {
      gifController.play(initialFrame: 0, inverted: false);
      bloc.add(OnForgetPassword(email: emailController.text));
    }

    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                GifView.asset(
                  'images/icons/email.gif',
                  height: 150,
                  width: 150,
                  frameRate: 30,
                  controller: gifController,
                ),
                const SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      errorText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Почта',
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                MyButton(
                  text: 'Отправить',
                  isLoading: state.runtimeType == ForgetPasswordLoading,
                  onTapInside: send,
                  onTapOutside: () {
                    errorText =
                        'Напишите вашу почту, чтобы мы могли отправить ссылку на сброс пароля';
                    bloc.add(OnUpdateForgetPassword());
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Вспомнили пароль?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        context.router.back();
                      },
                      child: const Text(
                        'Войти',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
