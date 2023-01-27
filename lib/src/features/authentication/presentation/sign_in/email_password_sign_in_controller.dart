// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  EmailPasswordSignInController({
    required EmailPasswordSignInFormType formType,
    required this.authRepository,
  }) : super(EmailPasswordSignInState(formType: formType));

  final FakeAuthRepository authRepository; 

  Future<bool> submit({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(value: const AsyncValue.loading());

    final value = await AsyncValue.guard(
        () => _authenticate(email: email, password: password));

    state = state.copyWith(value: value);

    return value.hasError == false;
  }

  Future<void> _authenticate({
    required String email,
    required String password,
  }) {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(
            email: email, password: password);

      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(
            email: email, password: password);
    }
  }

  void updateFormType(EmailPasswordSignInFormType formType) {
    state = state.copyWith(formType: formType);
  }
}

final emailPasswordSignInScreenControllerProvider =
    StateNotifierProvider.autoDispose.family<EmailPasswordSignInController,
        EmailPasswordSignInState, EmailPasswordSignInFormType>((ref, formType) {
  final authRepository = ref.watch(authRepositoryProvider);

  return EmailPasswordSignInController(
      authRepository: authRepository, formType: formType);
});
