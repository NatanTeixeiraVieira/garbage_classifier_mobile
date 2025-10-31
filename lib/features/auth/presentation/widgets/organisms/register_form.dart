import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/cubits/register_cubit.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/molecules/address_form_section.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/molecules/personal_info_form_section.dart';
import 'package:garbage_classifier_mobile/features/auth/presentation/widgets/molecules/register_actions.dart';

class RegisterForm extends StatefulWidget {
  final Function() onRegisterSuccess;
  final Function() onGoToLogin;

  const RegisterForm({
    super.key,
    required this.onRegisterSuccess,
    required this.onGoToLogin,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cepController = TextEditingController();
  final streetController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();

  late final AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    nameController.dispose();
    emailController.dispose();
    streetController.dispose();
    neighborhoodController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          widget.onRegisterSuccess();
        }
      },
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PersonalInfoFormSection(
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 24),
              AddressFormSection(
                cepController: cepController,
                streetController: streetController,
                neighborhoodController: neighborhoodController,
                cityController: cityController,
                onCepChanged: (cep) {},
              ),
              const SizedBox(height: 24),
              RegisterActions(
                buttonAnimationController: _buttonController,
                onRegister: () {
                  if (formKey.currentState!.validate()) {
                    context.read<RegisterCubit>().register(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          cep: cepController.text,
                          street: streetController.text,
                          neighborhood: neighborhoodController.text,
                          city: cityController.text,
                        );
                  }
                },
                onGoToLogin: widget.onGoToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
