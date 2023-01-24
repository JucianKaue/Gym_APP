import 'dart:ffi';

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
    return 'A senha precisa ter no mínimo:\n - uma letra;\n - um número;\n - um caractere especial;\n - 8 digitos.';
  }

  String? isValidEmail(String? value) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (emailRegExp.hasMatch(value!)) return null;
    return 'Email Incorreto!';
  }

  String? isValidCpf(String? value) {
    if (CPFValidator.isValid(value)) return null;
    return 'CPF inválido';
  }

  String? passwordsMatch(String? password1, String? password2)  {
    if (password1 != password2) return 'As senhas estão diferentes.';
    return null;
  }

  String? isAge(int? age) {
    if (age! > 122) {
      return "Você tem $age anos??\nParabéns, você está no Guinness Book!";
    } else if (age < 0) {
      return "Infelizmente você precisa ter nascido para entrar no app,\n espere ${age*-1} anos ou coloque uma idade positiva.";
    }
    return null;
  }

  String? isHeight(int? height) {
    if (height! > 274) {
      return "Você tem $height cm de altura??\nParabéns, você está no Guinness Book!";
    } else if (height <= 0) {
      return "Você precisa existir para criar uma conta.\nA sua altura precisa ser maior que 0.";
    }
    return null;
  }

  String? isWeigth(int? weight) {
    if (weight! > 597) {
      return "Você deveria estar no Guinness Book.\nPorém isso é preocupante...";
    } else if (weight < 0) {
      return "Você precisa existir para criar uma conta.\nO seu peso precisa ser maior que 0.";
    }
    return null;
  }

  String? maxLength(String? value, int num, [String? message]) {
    if (value!.length > num) return message ?? 'O numéro maximo de caracteres é $num';
    return null;
  }

  String? minLength(String? value, int num, [String? message]) {
    if (value!.length < num) return message ?? 'O numéro maximo de caracteres é $num';
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