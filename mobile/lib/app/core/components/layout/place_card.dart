import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const PlaceCard({
    Key? key,
    required this.place,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: CColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [CColors.shadow],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image.network(
                    place.images.first,
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: constraints.maxWidth * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FWeight.semiBold,
                            color: CColors.title,
                          ),
                        ),
                        Text(
                          place.description,
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 10,
                            color: CColors.gray,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_sharp,
                              color: CColors.primary,
                              size: 16,
                            ),
                            Text(
                              place.city,
                              style: const TextStyle(
                                fontSize: 10,
                                color: CColors.gray,
                              ),
                            )
                          ],
                        ),
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
                            if (onDelete != null)
                              GestureDetector(
                                onTap: onDelete,
                                child: const Icon(
                                  Icons.delete,
                                  color: CColors.red,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
