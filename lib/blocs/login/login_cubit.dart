import 'package:bloc/bloc.dart';
import 'package:frontend_apz/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  var _authRepository = AuthRepositoryImpl();
  LoginCubit(this._authRepository) : super(LoginInitialState());

  void login() {}
}
