import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_provider/features/auth/presentation/providers/register_form_provider.dart';
import '../../../shared/widgets/custom_filled_button.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Icon Banner
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (!context.canPop()) return;
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded,
                        size: 20, color: Colors.black)),
                const Spacer(flex: 1),
                Text('Crear cuenta',
                    style:
                        textStyles.titleLarge?.copyWith(color: Colors.black)),
                const Spacer(flex: 2),
              ],
            ),

            const SizedBox(height: 0),

            Container(
              height: size.height - 150,
              // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _RegisterForm(),
            )
          ],
        ),
      )),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          // const SizedBox( height: 30 ),

          // const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Nombre',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onNameChanged,

          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Apellido',
            keyboardType: TextInputType.text,
            onChanged:
                ref.read(registerFormProvider.notifier).onLastNameChanged,

          ),
          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.email.errorMessage
                : null,
          ),
          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged:
                ref.read(registerFormProvider.notifier).onPasswordChanged,
            onFieldSubmitted: (_) =>
                ref.read(registerFormProvider.notifier).onFormSubmit(),
            errorMessage: registerForm.isFormPosted
                ? registerForm.password.errorMessage
                : null,
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            label: 'role: supplier / store',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onRoleChanged,

          ),
          const SizedBox(height: 10),

          SizedBox(
              width: double.infinity,
              height: 30,
              child: CustomFilledButton(
                text: 'Crear',
                buttonColor: Colors.black,
                onPressed: registerForm.isPosting
                    ? null
                    : () async {
                        final success = await ref
                            .read(registerFormProvider.notifier)
                            .onFormSubmit();
                        if (success) {
                          context.go('/login');
                        }
                      },
              )),

          const Spacer(flex: 2),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                  onPressed: () {
                    if (context.canPop()) {
                      return context.pop();
                    }
                    context.go('/login');
                  },
                  child: const Text('Ingresa aquí'))
            ],
          ),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
