import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:turistando/app/core/components/dialogs/select_location_dialog.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/models/location_model.dart';
import 'package:turistando/app/core/store/location_store.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

class LocationAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LocationAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<LocationAppBar> createState() => _LocationAppBarState();
}

class _LocationAppBarState extends State<LocationAppBar> {
  final locationStore = locator.get<LocationStore>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showSelectLocationDialog(
                  context,
                  onTapCurrentLocation: () {
                    locationStore.getUserLocation();
                    Navigator.pop(context);
                  },
                  onTapPickOnMap: () {
                    Navigator.pop(context);
                    context.push("/pick-on-map");
                  },
                );
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: CColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: locationStore,
                    builder: (context, LocationModel state, child) {
                      return Text(
                        state.cityName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FWeight.bold,
                          color: CColors.title,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: CColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "${Assets.icons}/plane.svg",
                ),
              ),
            ),
          ),
        ],
      ),
      leading: null,
    );
  }
}
