import 'package:cpf_cnpj_validator/cpf_validator.dart';

mixin ValidationMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value == null || value.isEmpty)  return message ?? 'Esse campo não pode estar vazio!';
    return null;
  }

  String? isValidUsername(String? value) {
    final emailRegExp = RegExp(r'([a-zA-Z0-9])');
    if (emailRegExp.hasMatch(value!)) return null;
    return 'Apenas letras são permitidas';
  }

  String? isValidPassword(String? value) {
    final emailRegExp = RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}');
    if (emailRegExp.hasMatch(value!)) return null;
    return 'A senha precisa ter no mínimo uma letra, um número, um caractere especial e 8 digitos.';
  }

  String? isValidEmail(String? value) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (emailRegExp.hasMatch(value!)) return null;
    return 'Email Incorreto!';
  }

  String? isValidCpf(String? value) {
    if (CPFValidator.isValid(value)) return null;
    return 'CPF inválido';
  }

  String? passwordsMatch(String? password1, String? password2)  {
    if (password1 != password2) return 'As senhas diferentes.';
    return null;
  }

  String? maxLength(String? value, int num, [String? message]) {
    if (value!.length > num) return 'O numéro maximo de caracteres é $num';
    return null;
  }

  String? minLength(String? value, int num, [String? message]) {
    if (value!.length < num) return 'O numéro maximo de caracteres é $num';
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }

    return null;
  }
}