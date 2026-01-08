import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/features/pet.model.dart';
import '../../../../core/theme/app.colors.dart';

class PetSliderWidget extends StatelessWidget {
  final List<PetModel> pets;
  final VoidCallback? onAddPressed;
  final Function(PetModel)? onPetPressed;

  const PetSliderWidget({
    super.key,
    required this.pets,
    this.onAddPressed,
    this.onPetPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Meus Pets",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.pets, size: 18.sp, color: AppColors.primary),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: pets.length + 1,
            itemBuilder: (context, index) {
              if (index < pets.length) {
                return _buildPetItem(pets[index]);
              }
              return _buildAddPetButton();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPetItem(PetModel pet) {
    return GestureDetector(
      onTap: () => onPetPressed?.call(pet),
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: pet.borderColor.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 32.r,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage(pet.imageUrl),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      color: pet.hasWarning ? Colors.orange : Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      pet.hasWarning ? Icons.priority_high : Icons.check,
                      size: 10.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              pet.name,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPetButton() {
    return GestureDetector(
      onTap: onAddPressed,
      child: Column(
        children: [
          Container(
            width: 70.r,
            height: 70.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            child: Icon(Icons.add, color: Colors.grey.shade400, size: 30.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            "Novo",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
