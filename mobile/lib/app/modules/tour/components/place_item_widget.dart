// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class PlaceItemWidget extends StatelessWidget {
  final PlaceModel place;

  const PlaceItemWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return Row(
            children: [
              Center(
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    color: CColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CColors.title,
                        fontWeight: FWeight.bold,
                      ),
                    ),
                    Text(
                      place.city,
                      style: const TextStyle(
                        fontSize: 12,
                        color: CColors.gray,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    RatingStars(
                      starSize: 16,
                      value: place.rate / 2,
                      starCount: 5,
                      starColor: CColors.primary,
                      starOffColor: CColors.primary.withOpacity(0.25),
                      valueLabelVisibility: false,
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  place.images.first,
                  height: double.infinity,
                  width: constraints.maxWidth * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
