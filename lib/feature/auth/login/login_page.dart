import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_fishtank/core/repositories/auth/auth_failure.dart';
import 'package:smart_fishtank/core/repositories/failure.dart';
import 'package:smart_fishtank/feature/theme/fishtank_theme.dart';
import 'package:smart_fishtank/generated/assets.gen.dart';
import 'package:smart_fishtank/generated/l10n.dart';
import 'package:smart_fishtank/home/home_page.dart';
import 'package:smart_fishtank/widgets/dialog/error_dialog.dart';

import 'cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String path = '/login';
  static const String name = 'login';

  @override
  Widget build(BuildContext context) {
    final myTheme = FishTankTheme.of(context);

    return BlocProvider(
      create: (_) => GetIt.I<LoginCubit>(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: myTheme.backgroundGradient,
          ),
          child: const LoginContent(),
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

  // final emailCont = TextEditingController();
  // final passwordCont = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool passwordObscure = true;

  final GlobalKey<FormState> formKey = GlobalKey();

  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      autoValidateMode = AutovalidateMode.onUserInteraction;
    });

    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginCubit>().login(emailCont.text, passwordCont.text);
  }

  void _showModalError(Failure failure) {
    if (failure is AuthFailure) {
      return;
    }
    ErrorDialog.show(context, failure);
  }

  String? _getErrorField(Failure failure) {
    return switch (failure) {
      WrongEmailFailure() => 'Nie poprawny email',
      UserDisabledFailure() => 'Użytkownik został zablokowany',
      WrongCredentialsFailure() => 'Nie poprawny email lub hasło',
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (_, state) {
        if (state is SuccessLoginState) {
          TextInput.finishAutofillContext();
          context.replaceNamed(HomePage.name);
        } else if (state is FailureLoginState) {
          _showModalError(state.failure);
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AutofillGroup(
            onDisposeAction: AutofillContextAction.cancel,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.images.fishtankLogo.image(width: 110),
                  BlocSelector<LoginCubit, LoginState, AuthFailure?>(
                      selector: (state) => (state is FailureLoginState &&
                              state.failure is AuthFailure)
                          ? state.failure as AuthFailure
                          : null,
                      builder: (context, failure) {
                        return TextFormField(
                          controller: emailCont,
                          autovalidateMode: autoValidateMode,
                          decoration: InputDecoration(
                            label: Text(S.of(context).email),
                            errorText: failure != null
                                ? _getErrorField(failure)
                                : null,
                          ),
                          autofillHints: const [AutofillHints.email],
                          onChanged: (_) =>
                              context.read<LoginCubit>().clearError(),
                          validator:
                              ValidationBuilder().email().maxLength(50).build(),
                          textInputAction: TextInputAction.next,
                        );
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordCont,
                    autovalidateMode: autoValidateMode,
                    onFieldSubmitted: (_) => submit(),
                    decoration: InputDecoration(
                      label: Text(S.of(context).password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          key: ValueKey(passwordObscure),
                        ),
                        onPressed: () {
                          setState(() {
                            passwordObscure = !passwordObscure;
                          });
                        },
                      ),
                    ),
                    obscureText: passwordObscure,
                    autofillHints: const [AutofillHints.password],
                    textInputAction: TextInputAction.done,
                    validator: ValidationBuilder().build(),
                  ),
                  const SizedBox(height: 30),
                  BlocSelector<LoginCubit, LoginState, bool>(
                    selector: (state) => state is LoadingLoginState,
                    builder: (_, isLoading) {
                      return ElevatedButton(
                        onPressed: submit,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 110),
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(S.of(context).signIn),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
