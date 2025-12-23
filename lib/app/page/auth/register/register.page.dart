import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import '../../../core/widgets/paw_logo.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import '../../../core/widgets/primary_button.widget.dart';
import '../../../core/widgets/diviser.widget.dart';
import '../../../core/widgets/social_login_button.widget.dart';
import '../../../core/widgets/text_button.widget.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/theme/app.effects.dart';
import 'register.controller.dart';
import 'register.state.dart';
import '../../../core/utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterController(),
      child: BlocBuilder<RegisterController, RegisterState>(
        builder: (context, state) {
          final controller = context.read<RegisterController>();
          return BlocListener<RegisterController, RegisterState>(
            listener: (context, state) {
              if (state is RegisterError) {
                AlertDialogWidget.show(
                  context,
                  title: 'Erro',
                  message: state.message,
                );
              }
              if (state is RegisterSuccess) context.go('/home');
            },
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: Stack(
                children: [
                  AppEffects.buildRegisterBackground,
                  SafeArea(
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 24.w,
                              left: 24.w,
                              bottom: 24.h,
                              top: 24.h,
                            ),
                            child: Column(
                              children: [
                                Spacer(flex: 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    PawLogoWidget(),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'PetCare Express',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 22.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Crie sua conta',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(fontSize: 26.sp),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Cuide do seu melhor amigo com facilidade.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: AppColors.textSubtle),
                                ),
                                SizedBox(height: 18.h),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextFieldWidget(
                                        controller: nameController,
                                        label: 'Nome Completo',
                                        keyboardType: TextInputType.name,
                                        prefixIcon: Icons.person,
                                        prefixIconColor: AppColors.primary,
                                        validator: Validators.validateName,
                                      ),
                                      SizedBox(height: 12.h),
                                      TextFieldWidget(
                                        controller: emailController,
                                        label: 'E-mail',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: Validators.validateEmail,
                                        prefixIcon: Icons.email,
                                        prefixIconColor: AppColors.primary,
                                      ),
                                      SizedBox(height: 12.h),
                                      TextFieldWidget(
                                        controller: passwordController,
                                        label: 'Senha',
                                        isPassword: true,
                                        validator: Validators.validatePassword,
                                        prefixIcon: Icons.lock,
                                        prefixIconColor: AppColors.primary,
                                      ),
                                      SizedBox(height: 12.h),
                                      TextFieldWidget(
                                        controller: confirmPasswordController,
                                        label: 'Confirmar Senha',
                                        isPassword: true,
                                        validator: (value) =>
                                            Validators.confirmPassword(
                                              value,
                                              passwordController.text,
                                            ),
                                        prefixIcon: Icons.lock_outline,
                                        prefixIconColor: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: controller.acceptedTerms,
                                      onChanged: (value) => setState(
                                        () => controller.setAcceptedTerms(
                                          value ?? false,
                                        ),
                                      ),
                                      activeColor: AppColors.primary,
                                    ),
                                    TextButtonWidget(
                                      primaryText: 'Aceito os',
                                      secondaryText: 'termos e condições',
                                      primaryTextColor: AppColors.textMain,
                                      secondaryTextColor: AppColors.link,
                                      onPressed: () async {
                                        final result = await context.push(
                                          '/terms',
                                        );
                                        final accepted = (result == true);
                                        if (accepted) {
                                          controller.setAcceptedTerms(true);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                PrimaryButtonWidget(
                                  title: 'Criar Conta',
                                  isLoading: state is RegisterLoading,
                                  onPressed: (state is RegisterLoading)
                                      ? null
                                      : () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            controller.register(
                                              emailController.text,
                                              passwordController.text,
                                            );
                                          }
                                        },
                                ),
                                DivisorWidget(isNewAccount: true),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SocialLoginButtonWidget(
                                      icon: FaIcon(
                                        FontAwesomeIcons.google,
                                        color: AppColors.textMain,
                                        size: 24.sp,
                                      ),
                                      onTap: () {},
                                    ),
                                    SizedBox(width: 16.w),
                                    SocialLoginButtonWidget(
                                      icon: Icon(
                                        Icons.apple,
                                        size: 28.sp,
                                        color: AppColors.textMain,
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                TextButtonWidget(
                                  primaryText: 'Já tem uma conta?',
                                  secondaryText: 'Entrar',
                                  primaryTextColor: AppColors.textMain,
                                  secondaryTextColor: AppColors.link,
                                  onPressed: () => context.push('/login'),
                                ),
                                Spacer(flex: 1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
