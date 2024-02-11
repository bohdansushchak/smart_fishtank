import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_fishtank/auth/cubit/auth_cubit.dart';
import 'package:smart_fishtank/auth/login/cubit/login_cubit.dart';

import '../../core/app_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.isLoggedIn != curr.isLoggedIn,
      listener: (_, state) {
        if (state.isLoggedIn) {
          context.replaceNamed(AppRoute.home.name);
        }
      },
      child: BlocProvider(
        create: (_) => GetIt.I<LoginCubit>(),
        child: const Scaffold(
          body: LoginContent(),
        ),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final emailCont = TextEditingController(text: 'bsushchak@gmail.com');
  final passwordCont = TextEditingController(text: 'Molinezja2');

  final GlobalKey<FormState> formKey = GlobalKey();

  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    context.read<LoginCubit>().login(emailCont.text, passwordCont.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailCont,
                  decoration: InputDecoration(hintText: 'Login'),
                ),
                TextFormField(
                  controller: passwordCont,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: submit,
                  child: Text('Zaloguj'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
