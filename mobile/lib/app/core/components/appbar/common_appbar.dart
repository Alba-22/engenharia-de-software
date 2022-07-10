import 'package:flutter/material.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FWeight.bold,
          color: CColors.white,
        ),
      ),
      leading: Navigator.canPop(context)
          ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: CColors.white,
                size: 24,
              ),
            )
          : null,
    );
  }
}
