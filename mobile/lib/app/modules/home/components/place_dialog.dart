import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';
import 'package:turistando/app/core/components/buttons/mini_button.dart';
import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

void placeDialog(BuildContext context, PlaceModel place) {
  showDialog(
    context: context,
    anchorPoint: const Offset(0, 100),
    builder: (context) {
      return Dialog(
        alignment: Alignment.bottomCenter,
        insetPadding: const EdgeInsets.symmetric(vertical: 100),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            context.push("/place-details", extra: place);
          },
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width < 500
                ? MediaQuery.of(context).size.width * 0.9
                : 500,
            decoration: BoxDecoration(
              color: CColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          place.images.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FWeight.semiBold,
                              color: CColors.title,
                            ),
                          ),
                          Text(
                            place.district,
                            style: const TextStyle(
                              fontSize: 14,
                              color: CColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingStars(
                      value: place.rate / 2,
                      starCount: 5,
                      starColor: CColors.primary,
                      starOffColor: CColors.primary.withOpacity(0.25),
                      valueLabelVisibility: false,
                    ),
                    MiniButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: CColors.white,
                      ),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
