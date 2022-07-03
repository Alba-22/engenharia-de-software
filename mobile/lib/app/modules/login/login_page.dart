import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:ftoast/ftoast.dart';
import 'package:turistando/app/core/components/buttons/common_button.dart';
import 'package:turistando/app/core/components/buttons/reverse_button.dart';
import 'package:turistando/app/core/components/fields/common_field.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/validators.dart';
import 'package:turistando/app/modules/login/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final store = locator.get<LoginStore>();

  @override
  void initState() {
    super.initState();
    store.observer(
      onState: (LoginState state) {
        if (state is LoginSuccessState) {
          // context.go("entry");
        } else if (state is LoginErrorState) {
          FToast.toast(context, msg: state.message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "${Assets.images}/turistando_logo.png",
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "TURISTANDO",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CommonField(
                      label: "E-MAIL",
                      validator: Validators.emailValidator,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    CommonField(
                      label: "SENHA",
                      obscure: true,
                      validator: Validators.passwordValidator,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 56),
                    TripleBuilder(
                      store: store,
                      builder: (context, triple) {
                        return CommonButton(
                          text: "ENTRAR",
                          width: double.infinity,
                          isLoading: triple.state is LoginLoadingState,
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              store.login(emailController.text, passwordController.text);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ReverseButton(
                      text: "CRIAR UMA CONTA",
                      width: double.infinity,
                      onTap: () {},
                    ),
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
