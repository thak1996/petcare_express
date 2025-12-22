import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app.colors.dart';

class DogLogoWidget extends StatelessWidget {
  const DogLogoWidget({super.key});

  final String imageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDorGdl42NgnEGg8DOMbmVJ_07ZDWqmRFW87ig7i-Jsc0hBOXPqzqju1CkbbxwabKIbbkJG5YkfZQI7ad6DWHD4P8fTVCYR6QfYcK65PXpkq3NqjRtCuF0AFcfV0XDT7SCV69GIJm6n5fhF1g14DfjxPW_HIPvvA9-xI1MOcqHeAaRNcmaDIzpR72gWoxa92xS85x7IciiXODt0Y3G_w_F21-n2Xn6HSLwuhEgTViqB0HmF6ClUrxuwzd9AiRNj4zUml7dUjVZyAdCS';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.network(
          imageUrl,
          width: 75.w,
          height: 75.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.security, size: 64.r, color: AppColors.primary);
          },
        ),
      ),
    );
  }
}
