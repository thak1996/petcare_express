import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/theme/app.effects.dart';
import '../../../core/widgets/primary_button.widget.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  Widget _section(String title, String body) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textMain,
          fontSize: 14.sp,
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        body,
        style: TextStyle(color: AppColors.textSubtle, fontSize: 12.sp),
      ),
      SizedBox(height: 20.h),
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: Stack(
      children: [
        AppEffects.buildBackgroundDecoration,
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.pop(false),
                    ),
                    Expanded(
                      child: Text(
                        'Termos e Privacidade',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(width: 48.w),
                  ],
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppEffects.shadowSoft,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 18.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _section(
                                '1. Introdução',
                                'Bem-vindo ao PetCare Express! Estes Termos de Uso regulam o acesso e utilização da nossa plataforma dedicada ao cuidado e bem-estar do seu pet. Ao utilizar nossos serviços, você concorda com as condições descritas abaixo.',
                              ),
                              _section(
                                '2. Privacidade dos Dados',
                                'Bem-vindo ao PetCare Express! Estes Termos de Uso regulam o acesso e utilização da nossa plataforma dedicada ao cuidado e bem-estar do seu pet. Ao utilizar nossos serviços, você concorda com as condições descritas abaixo.',
                              ),
                              _section(
                                '3. Uso do Plataforma',
                                'O PetCare Express deve ser utilizado para agendar serviços, consultar dicas de saúde e gerenciar o perfil do seu animal de estimação. É proibido o uso para fins ilícitos ou que violem os direitos de terceiros.',
                              ),
                              _section(
                                '4. Pagamentos e Assinaturas',
                                'Os serviços premium são cobrados mensalmente. Você pode cancelar sua assinatura a qualquer momento através das configurações do aplicativo, sem multas, desde que feito antes da renovação automática.',
                              ),
                              _section(
                                '5. Atualizações',
                                'Podemos atualizar estes termos periodicamente. Notificaremos sobre mudanças significativas através do aplicativo ou por e-mail.',
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Última atualização: 24 de Outubro de 2025',
                                style: TextStyle(
                                  color: AppColors.textSubtle,
                                  fontSize: 11.sp,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              PrimaryButtonWidget(
                                title: 'Aceitar e Continuar',
                                onPressed: () => context.pop(true),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
