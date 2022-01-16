import 'package:flutter/material.dart';
import 'package:google_maps_location/core/_core_exports.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    Key? key,
    required this.text,
    this.onTap,
    this.color = AppColors.green,
  }) : super(key: key);
  final Function()? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: ScreenSize().getWidthPercent(.4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.blurColor,
              blurRadius: 15,
              spreadRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            text,
            style: AppTextStyles.openSansBold20Pt.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
