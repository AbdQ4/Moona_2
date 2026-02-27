import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/widgets/custom_addItem.dart';
import 'package:provider/provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTab;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final isLight = themeController.isLight;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// Navbar background
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: isLight
                    ? ColorsManager.grey.withAlpha(125)
                    : ColorsManager.green.withAlpha(125),
              ),
              color: isLight ? Colors.white : ColorsManager.green,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildItem(context, 0, Icons.home_outlined, Icons.home),
                _buildItem(
                  context,
                  1,
                  Icons.attach_money_outlined,
                  Icons.attach_money,
                ),
                SizedBox(width: 65.w), // space for FAB
                _buildItem(
                  context,
                  2,
                  Icons.credit_card_outlined,
                  Icons.credit_card,
                ),
                _buildItem(context, 3, Icons.person_outline, Icons.person),
              ],
            ),
          ),

          /// Center FAB space
          Positioned(
            top: -25.h,
            child: InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    insetPadding: REdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomAdditem(),
                  ),
                );
              },
              child: Container(
                height: 55.h,
                width: 55.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: isLight ? ColorsManager.green : ColorsManager.gold,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: 34.sp,
                  color: themeController.isLight
                      ? ColorsManager.white
                      : ColorsManager.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    IconData icon,
    IconData activeIcon,
  ) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    final isLight = themeController.isLight;
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: REdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isLight ? ColorsManager.green : ColorsManager.gold)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          size: isSelected ? 28.sp : 24.sp,
          color: isSelected
              ? (isLight ? Colors.white : ColorsManager.green)
              : (isLight ? ColorsManager.green : Colors.white70),
        ),
      ),
    );
  }
}
