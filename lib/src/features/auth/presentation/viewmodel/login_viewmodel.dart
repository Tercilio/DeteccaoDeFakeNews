import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/login_usecase.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final error = LoginError();
  final _usecase = Modular.get<LoginUseCase>();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @action
  void validateUsername() {
    error.email = _usecase.validateUsername(email);
  }

  @action
  void validatePassword() {
    error.password = _usecase.validatePassword(password);
  }

  void login() async {
    error.clear();

    validateUsername();
    validatePassword();

    // if (!error.hasErrors) {
    //   isLoading = true;
    //   try {
    //     await _usecase.login(email, password);
    //   } on UnimplementedError {
    //     // TODO: Fix!!!
    //     error.login = 'Função não implementada!';
    //   } finally {
    //     isLoading = false;
    //   }
    // }
  }
}

class LoginError = _LoginErrorBase with _$LoginError;

abstract class _LoginErrorBase with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? login;

  @computed
  bool get hasErrors => email != null || password != null || login != null;

  void clear() {
    email = null;
    password = null;
    login = null;
  }
}
