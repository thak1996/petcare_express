import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/test_keys.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/theme/app.effects.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/diviser.widget.dart';
import '../../../core/widgets/dog.widget.dart';
import '../../../core/widgets/primary_button.widget.dart';
import '../../../core/widgets/social_login_button.widget.dart';
import '../../../core/widgets/text_button.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import 'login.controller.dart';
import 'login.state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm({
    required BuildContext context,
    required LoginController controller,
  }) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      controller.login(
        UserModel(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => LoginController(context.read<IAuthRepository>()),
    child: Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<LoginController, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            AlertDialogWidget.show(
              context,
              title: 'Erro',
              message: state.message,
            );
          }
          if (state is LoginSuccess) context.go('/home');
        },
        builder: (context, state) {
          final controller = context.read<LoginController>();
          return Stack(
            children: [
              AppEffects.buildBackgroundDecoration,
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
                            const Spacer(flex: 1),
                            DogLogoWidget(),
                            SizedBox(height: 24.h),
                            Text(
                              'PetCare Express',
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(fontSize: 26.sp),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Cuidando do seu melhor amigo.',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: AppColors.textSubtitle,
                                    fontSize: 18.sp,
                                  ),
                            ),
                            const Spacer(flex: 1),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFieldWidget(
                                    key: Key(TestKeys.loginEmailField),
                                    controller: _emailController,
                                    label: 'E-mail',
                                    validator: Validators.validateEmail,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icons.email,
                                    prefixIconColor: AppColors.primary,
                                  ),
                                  SizedBox(height: 16.h),
                                  TextFieldWidget(
                                    key: Key(TestKeys.loginPasswordField),
                                    controller: _passwordController,
                                    label: 'Senha',
                                    validator: Validators.validatePassword,
                                    isPassword: true,
                                    prefixIcon: Icons.lock,
                                    prefixIconColor: AppColors.primary,
                                  ),
                                  SizedBox(height: 16.h),
                                  TextButtonWidget(
                                    key: Key(
                                      TestKeys.loginForgotPasswordButton,
                                    ),
                                    alignment: Alignment.topRight,
                                    primaryText: 'Esqueceu a senha?',
                                    primaryTextColor: AppColors.textSubtitle,
                                    fontWeightPrimary: FontWeight.w700,
                                    onPressed: () => context.push('/forgot'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            PrimaryButtonWidget(
                              key: const Key(TestKeys.loginSubmitButton),
                              title: 'Entrar',
                              isLoading: state is LoginLoading,
                              onPressed: (state is LoginLoading)
                                  ? null
                                  : () => _submitForm(
                                      context: context,
                                      controller: controller,
                                    ),
                            ),
                            DivisorWidget(),
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
                            SizedBox(height: 24.h),
                            TextButtonWidget(
                              key: Key(TestKeys.loginSignUpButton),
                              primaryText: 'Não tem uma conta?',
                              secondaryText: 'Cadastre-se!',
                              primaryTextColor: AppColors.textMain,
                              secondaryTextColor: AppColors.link,
                              onPressed: () => context.push('/register'),
                            ),
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
