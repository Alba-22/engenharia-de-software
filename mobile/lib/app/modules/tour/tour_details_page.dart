// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:turistando/app/core/components/appbar/common_appbar.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

import 'components/place_item_widget.dart';
import 'store/get_tour_details_store.dart';

class TourDetailsPage extends StatefulWidget {
  final int tourId;

  const TourDetailsPage({
    Key? key,
    required this.tourId,
  }) : super(key: key);

  @override
  State<TourDetailsPage> createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  final store = locator.get<GetTourDetailsStore>();

  @override
  void initState() {
    super.initState();
    store.getTourDetailsById(widget.tourId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "TOUR",
      ),
      body: ValueListenableBuilder(
        valueListenable: store,
        builder: (context, GetTourDetailsState state, child) {
          if (state is GetTourDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTourDetailsSuccessState) {
            return Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  state.tourDetails.title,
                  style: const TextStyle(
                    fontSize: 22,
                    color: CColors.title,
                    fontWeight: FWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.tourDetails.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: CColors.gray,
                  ),
                ),
                const SizedBox(height: 46),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.tourDetails.places.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PlaceItemWidget(
                        place: state.tourDetails.places[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                ),
              ],
            );
          }

          final value = store as GetTourDetailsErrorState;

          return Center(child: Text(value.message));
        },
      ),
    );
  }
}
