import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/service/storage/token.storage.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/theme/app.effects.dart';
import '../../../core/widgets/dog.widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    final token = await context.read<ITokenStorage>().getToken();
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    if (token != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: Stack(
      children: [
        AppEffects.buildRecoverySplash,
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
                      DogLogoWidget(size: 140),
                      SizedBox(height: 24.h),
                      Text(
                        'PetCare Express',
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(fontSize: 26.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Cuidando do seu melhor amigo.',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: AppColors.textSubtitle,
                              fontSize: 16.sp,
                            ),
                      ),
                      Spacer(flex: 1),
                      CircularProgressIndicator(color: AppColors.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
