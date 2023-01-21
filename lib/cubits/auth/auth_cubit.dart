import 'package:empire_app_ui/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());

  final apiService = ApiService.instance.restClient;

  Future<void> login(String email, String password) async {

    try {
      emit(const AuthState.loading());

      await apiService.login({"email": email, "password": password});

      emit(const AuthState.success());
    } catch (e) {
      Logger().e(e.toString());

      emit(const AuthState.error("Email or password is incorrect!"));
    }
  }

  Future<void> signup(String name, String email, String password) async {

    try {
      emit(const AuthState.loading());

      await apiService.signup({"name": name, "email": email, "password": password});

      emit(const AuthState.success());
    } catch (e) {
      Logger().e(e.toString());

      emit(const AuthState.error("Email is already registered!"));
    }
  }
}
