import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/repository/auth.repository.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/theme/app.effects.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import '../../../core/widgets/paw_logo.widget.dart';
import '../../../core/widgets/primary_button.widget.dart';
import '../../../core/widgets/text_button.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import '../../../core/utils/validators.dart';
import 'forgot.controller.dart';
import 'forgot.state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm({
    required BuildContext context,
    required ForgotController controller,
  }) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      controller.sendRecovery(UserModel(email: _emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ForgotController(context.read<IAuthRepository>()),
    child: Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<ForgotController, ForgotState>(
        listener: (context, state) {
          if (state is ForgotError) {
            AlertDialogWidget.show(
              context,
              title: 'Erro',
              message: state.message,
            );
          }
          if (state is ForgotSuccess) {
            AlertDialogWidget.show(
              context,
              title: 'Sucesso',
              message: 'Enviamos um link de recuperação para seu e-mail.',
            );
          }
        },
        builder: (context, state) {
          final controller = context.read<ForgotController>();
          return Stack(
            children: [
              AppEffects.buildRecoveryBackground,
              SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 24.w,
                          left: 24.w,
                          top: 24.h,
                          bottom: 24.h,
                        ),
                        child: Column(
                          children: [
                            const Spacer(flex: 1),
                            PawLogoWidget(
                              sizeContainer: 80.w,
                              sizeIcon: 60.w,
                              border: PawLogoBorder.circle,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Recuperar senha',
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(fontSize: 24.sp),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Insira o e-mail associado à sua conta. Enviaremos um link para redefinir sua senha.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: AppColors.textSubtle,
                                    fontSize: 18.sp,
                                  ),
                            ),
                            SizedBox(height: 24.h),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'E-mail',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8.h),
                                  TextFieldWidget(
                                    controller: _emailController,
                                    label: 'exemplo@petcare.com',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: Validators.validateEmail,
                                    prefixIcon: Icons.email,
                                    prefixIconColor: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            PrimaryButtonWidget(
                              title: 'Enviar link',
                              isLoading: state is ForgotLoading,
                              onPressed: (state is ForgotLoading)
                                  ? null
                                  : () => _submitForm(
                                      context: context,
                                      controller: controller,
                                    ),
                            ),
                            const Spacer(flex: 1),
                            TextButtonWidget(
                              primaryText: 'Lembrou a senha?',
                              secondaryText: 'Entrar',
                              primaryTextColor: AppColors.textMain,
                              secondaryTextColor: AppColors.link,
                              onPressed: () => context.push('/login'),
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
