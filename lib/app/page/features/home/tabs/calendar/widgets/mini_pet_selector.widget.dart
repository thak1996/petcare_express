import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/models/features/pet.model.dart';
import '../../../../../../core/theme/app.colors.dart';

class MiniPetSelectorWidget extends StatelessWidget {
  final List<PetModel> pets;
  final String? selectedPetId;
  final Function(String?) onPetSelected;

  const MiniPetSelectorWidget({
    super.key,
    required this.pets,
    this.selectedPetId,
    required this.onPetSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: pets.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildPetAvatar(
              label: "Todos",
              isSelected: selectedPetId == null,
              onTap: () => onPetSelected(null),
              icon: Icons.pets,
            );
          }
          final pet = pets[index - 1];
          return _buildPetAvatar(
            label: pet.name,
            image: pet.imageUrl,
            isSelected: selectedPetId == pet.id,
            onTap: () => onPetSelected(pet.id),
          );
        },
      ),
    );
  }

  Widget _buildPetAvatar({
    required String label,
    String? image,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 16.w),
        child: Column(
          children: [
            Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade200,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
              ),
              child: Center(
                child: image != null 
                  ? CircleAvatar(backgroundImage: NetworkImage(image), radius: 22.r)
                  : Icon(icon ?? Icons.pets, color: isSelected ? AppColors.primary : Colors.grey),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}