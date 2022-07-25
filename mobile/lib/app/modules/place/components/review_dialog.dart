import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:turistando/app/core/components/buttons/common_button.dart';
import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

showReviewDialog(BuildContext context, PlaceModel place) {
  showDialog(
    context: context,
    builder: (context) {
      return ReviewDialog(place: place);
    },
  );
}

class ReviewDialog extends StatefulWidget {
  final PlaceModel place;
  const ReviewDialog({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double stars = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 100),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: 220,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: CColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              "AVALIAÇÃO",
              style: TextStyle(
                fontSize: 16,
                color: CColors.gray,
              ),
            ),
            Text(
              widget.place.name,
              style: const TextStyle(
                fontSize: 20,
                color: CColors.title,
                fontWeight: FWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: RatingStars(
                value: stars,
                starCount: 5,
                maxValue: 5,
                starColor: CColors.primary,
                starOffColor: CColors.primary.withOpacity(0.25),
                valueLabelVisibility: false,
                starSize: 36,
                onValueChanged: (double value) {
                  setState(() {
                    stars = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            CommonButton(
              text: "ENVIAR AVALIAÇÃO",
              width: double.infinity,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
