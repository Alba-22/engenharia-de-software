import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';
import 'package:turistando/app/core/components/buttons/common_button.dart';
import 'package:turistando/app/core/components/buttons/favorite_button.dart';

import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class PlaceDetailsPage extends StatefulWidget {
  final PlaceModel place;

  const PlaceDetailsPage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: widget.place.images.map((e) {
                        return Image.network(e);
                      }).toList(),
                      options: CarouselOptions(
                        height: 250,
                        autoPlay: widget.place.images.length > 1 ? true : false,
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).padding.top +
                          MediaQuery.of(context).size.width * 0.05,
                      child: InkWell(
                        onTap: () => context.pop(),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: CColors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ), // Carousel
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        widget.place.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FWeight.bold,
                          color: CColors.title,
                        ),
                      ),
                      Text(
                        widget.place.formattedAddress,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FWeight.bold,
                          color: CColors.gray,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "AVALIAÇÕES",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FWeight.semiBold,
                                  color: CColors.title,
                                ),
                              ),
                              const SizedBox(height: 4),
                              RatingStars(
                                value: widget.place.rate / 2,
                                starCount: 5,
                                starColor: CColors.primary,
                                starOffColor: CColors.primary.withOpacity(0.25),
                                valueLabelVisibility: false,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "AVALIAR",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FWeight.semiBold,
                                color: CColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "DESCRIÇÃO",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FWeight.semiBold,
                          color: CColors.title,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.place.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FWeight.medium,
                            color: CColors.gray,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          FavoriteButton(
                            isFavorited: false,
                            onTap: () {},
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonButton(
                              text: "ADICIONAR AO TOUR",
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
