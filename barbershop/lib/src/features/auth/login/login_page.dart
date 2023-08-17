import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import 'login_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginVM = ref.watch(loginVMProvider.notifier);

    ref.listen(loginVMProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStatus.initial):
          break;
        case LoginState(status: LoginStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStatus.error):
          Messages.showError('Ocorreu um erro ao realizar login.', context);
        case LoginState(status: LoginStatus.admLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/admin', (route) => false);
        case LoginState(status: LoginStatus.employeeLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/employee', (route) => false);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.backgroundChair),
            fit: BoxFit.cover,
            opacity: 0.28,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: formKey,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 36),
                            child: Image.asset(ImageConstants.logo),
                          ),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            controller: emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                              hintText: 'E-mail',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus(),
                            controller: passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatório'),
                              Validatorless.min(
                                  6, 'A Senha deve conter ao menos 6 caracteres'),
                            ]),
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () async {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                    'Campos e-mail ou senha inválidos!',
                                    context,
                                  );
                                case true:
                                  await loginVM.login(emailEC.text, passwordEC.text);
                              }
                            },
                            child: const Text(
                              'Acessar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
