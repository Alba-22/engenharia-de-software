import 'package:flutter/material.dart';
import 'package:turistando/app/core/components/buttons/common_button.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

showSelectLocationDialog(
  BuildContext context, {
  required VoidCallback onTapCurrentLocation,
  required VoidCallback onTapPickOnMap,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return SelectionLocationDialog(
        onTapCurrentLocation: onTapCurrentLocation,
        onTapPickOnMap: onTapPickOnMap,
      );
    },
  );
}

class SelectionLocationDialog extends StatelessWidget {
  final VoidCallback onTapCurrentLocation;
  final VoidCallback onTapPickOnMap;

  const SelectionLocationDialog({
    Key? key,
    required this.onTapCurrentLocation,
    required this.onTapPickOnMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 260,
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "SELECIONAR LOCALIZAÇÃO",
              style: TextStyle(
                fontWeight: FWeight.bold,
                color: CColors.title,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Sua localização é necessária para podermos te mostrar os melhores lugares e tours.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FWeight.medium,
                color: CColors.gray,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 24),
            CommonButton(
              width: double.infinity,
              text: "LOCALIZAÇÃO ATUAL",
              onTap: onTapCurrentLocation,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 2,
                  decoration: BoxDecoration(
                    color: CColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "OU",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FWeight.bold,
                    color: CColors.title,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 60,
                  height: 2,
                  decoration: BoxDecoration(
                    color: CColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CommonButton(
              width: double.infinity,
              text: "ESCOLHER NO MAPA",
              onTap: onTapPickOnMap,
            ),
          ],
        ),
      ),
    );
  }
}
