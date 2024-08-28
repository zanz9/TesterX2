import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_view/gif_view.dart';
import 'package:testerx2/presentation/auth/auth.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';

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
      if (emailController.text.isEmpty) return;
      gifController.play(initialFrame: 0, inverted: false);
      bloc.add(OnForgetPassword(
          email: emailController.text, gifController: gifController));
    }

    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
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
                            color: Colors.grey.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    EmailInput(
                      emailController: emailController,
                      onSubmitted: send,
                    ),
                    const SizedBox(height: 25),
                    PrimaryButton(
                      onTap: send,
                      onTapOutside: () {
                        errorText =
                            'Напишите вашу почту, чтобы мы могли отправить ссылку на сброс пароля';
                        bloc.add(OnUpdateForgetPassword());
                      },
                      isLoading: state is ForgetPasswordLoading,
                      child: const Text(
                        'Отправить',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Вспомнили пароль?',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => context.router.back(),
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
