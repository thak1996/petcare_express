import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import '../../../core/widgets/paw_logo.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import '../../../core/widgets/primary_button.widget.dart';
import '../../../core/widgets/diviser.widget.dart';
import '../../../core/widgets/social_login_button.widget.dart';
import '../../../core/widgets/text_button.widget.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/theme/app.effects.dart';
import '../../../core/utils/validators.dart';
import 'register.controller.dart';
import 'register.state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submiteForm({
    required BuildContext context,
    required RegisterController controller,
  }) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      controller.register(
        UserModel(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => RegisterController(context.read<IAuthRepository>()),
    child: Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<RegisterController, RegisterState>(
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
        builder: (context, state) {
          final controller = context.read<RegisterController>();
          return Stack(
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
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(fontSize: 26.sp),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Cuide do seu melhor amigo com facilidade.',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(color: AppColors.textSubtle),
                            ),
                            SizedBox(height: 18.h),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFieldWidget(
                                    controller: _nameController,
                                    label: 'Nome Completo',
                                    keyboardType: TextInputType.name,
                                    prefixIcon: Icons.person,
                                    prefixIconColor: AppColors.primary,
                                    validator: Validators.validateName,
                                  ),
                                  SizedBox(height: 12.h),
                                  TextFieldWidget(
                                    controller: _emailController,
                                    label: 'E-mail',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: Validators.validateEmail,
                                    prefixIcon: Icons.email,
                                    prefixIconColor: AppColors.primary,
                                  ),
                                  SizedBox(height: 12.h),
                                  TextFieldWidget(
                                    controller: _passwordController,
                                    label: 'Senha',
                                    isPassword: true,
                                    validator: Validators.validatePassword,
                                    prefixIcon: Icons.lock,
                                    prefixIconColor: AppColors.primary,
                                  ),
                                  SizedBox(height: 12.h),
                                  TextFieldWidget(
                                    controller: _confirmPasswordController,
                                    label: 'Confirmar Senha',
                                    isPassword: true,
                                    validator: (value) =>
                                        Validators.confirmPassword(
                                          value,
                                          _passwordController.text,
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
                                      '/termsLogin',
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
                                  : () => _submiteForm(
                                      context: context,
                                      controller: controller,
                                    ),
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
                                  onTap: () => log('Login Google'),
                                ),
                                SizedBox(width: 16.w),
                                SocialLoginButtonWidget(
                                  icon: Icon(
                                    Icons.apple,
                                    size: 28.sp,
                                    color: AppColors.textMain,
                                  ),
                                  onTap: () => log('Login Apple'),
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
          );
        },
      ),
    ),
  );
}
