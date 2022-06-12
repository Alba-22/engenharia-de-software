import 'package:email_validator/email_validator.dart';

abstract class Validators {
  static bool _isEmpty(String? value) => value == null || value.trim().isEmpty;

  static String? emailValidator(String? value) {
    if (_isEmpty(value)) {
      return "É necessário digitar o e-mail!";
    } else if (!EmailValidator.validate(value!.trim())) {
      return "E-mail inválido";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (_isEmpty(value)) {
      return "É necessário digitar a senha!";
    } else if (value!.trim().length < 6) {
      return "A senha deve ter pelo menos 6 caracteres";
    }

    return null;
  }

  static String? requiredValidator(String? value) {
    if (_isEmpty(value)) {
      return "O campo é obrigatório!";
    }

    return null;
  }
}
