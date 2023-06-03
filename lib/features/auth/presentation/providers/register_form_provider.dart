import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:ur_provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:ur_provider/features/shared/shared.dart';

//! 3 - StateNotifierProvider - consume afuera
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

//! 2 - Como implementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, String, String) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback,
  }) : super(RegisterFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  onNameChanged(String value) {
    state = state.copyWith(name: value, isValid: true);
  }

  onLastNameChanged(String value) {
    state = state.copyWith(lastName: value, isValid: true);
  }

  onRoleChanged(String value) {
    state = state.copyWith(role: value, isValid: true);
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);

    try {
      await registerUserCallback(state.email.value, state.password.value,
          state.name, state.lastName, state.role);
      return true;
    } catch (e) {
      print('Error al autenticar: $e');
      return false;
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}

//! 1 - State del provider
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final String name;
  final String lastName;
  final String role;

  RegisterFormState(
      {this.name = '',
      this.lastName = '',
      this.role = '',
      this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    String? name,
    String? lastName,
    String? role,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        role: role ?? this.role,
      );

  @override
  String toString() {
    return '''
  RegisterFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
    name: $name
    lastName: $lastName
    role: $role
''';
  }
}
