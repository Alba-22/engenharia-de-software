import 'package:flutter/material.dart';
import 'package:turistando/app/core/components/appbar/location_appbar/location_appbar.dart';
import 'package:turistando/app/core/components/layout/tour_card.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

import 'stores/get_highlighted_tours_store.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final store = locator.get<GetHighlightedToursStore>();

  @override
  void initState() {
    super.initState();
    store.getHighlightedTours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: ValueListenableBuilder(
          valueListenable: store,
          builder: (context, GetHighlightedToursState state, child) {
            if (state is GetHighlightedToursLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetHighlightedToursSuccessState) {
              return ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: state.tours.length,
                itemBuilder: (BuildContext context, int index) {
                  final tour = state.tours[index];

                  return Column(
                    children: [
                      if (index == 0)
                        Container(
                          margin: const EdgeInsets.only(
                            top: 12,
                            bottom: 16,
                          ),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "TOURS RECOMENDADOS",
                            style: TextStyle(
                              fontSize: 18,
                              color: CColors.title,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      TourCard(
                        tour: tour,
                        onTap: () {},
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 8);
                },
              );
            }

            final value = store as GetHighlightedToursErrorState;

            return Center(child: Text(value.message));
          },
        ),
      ),
    );
  }
}
