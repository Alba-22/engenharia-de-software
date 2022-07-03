import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:ftoast/ftoast.dart';
import 'package:go_router/go_router.dart';
import 'package:turistando/app/core/components/fields/common_field.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';
import 'package:turistando/app/core/utils/validators.dart';

import '../../core/components/buttons/common_button.dart';
import 'register_store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final store = locator.get<RegisterStore>();

  @override
  void initState() {
    super.initState();
    store.observer(
      onState: (RegisterState state) {
        if (state is RegisterSuccessState) {
          // context.go("entry")
        } else if (state is RegisterErrorState) {
          FToast.toast(context, msg: state.message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "CRIAR CONTA",
          style: TextStyle(
            color: CColors.white,
            fontWeight: FWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: context.pop,
          child: const Icon(
            Icons.arrow_back_ios,
            color: CColors.white,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: const Text(
                  "Preencha os campos abaixo para criar sua conta gratuitamente e explorar o mundo!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CColors.title,
                    fontSize: 16,
                    fontWeight: FWeight.semiBold,
                  ),
                ),
              ),
              CommonField(
                label: "NOME",
                validator: Validators.requiredValidator,
                controller: nameController,
              ),
              const SizedBox(height: 16),
              CommonField(
                label: "E-MAIL",
                validator: Validators.emailValidator,
                controller: emailController,
              ),
              const SizedBox(height: 16),
              CommonField(
                label: "TELEFONE",
                validator: Validators.phoneValidator,
                controller: phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
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
                    text: "CRIAR CONTA",
                    width: double.infinity,
                    isLoading: triple.state is RegisterLoadingState,
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        store.register(
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                          passwordController.text,
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
