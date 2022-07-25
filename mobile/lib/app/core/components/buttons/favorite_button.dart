import 'package:flutter/material.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class FavoriteButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isFavorited;

  const FavoriteButton({
    Key? key,
    required this.onTap,
    required this.isFavorited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CColors.fakeWhite,
        ),
        child: Center(
          child: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border_rounded,
            color: CColors.primary,
          ),
        ),
      ),
    );
  }
}
