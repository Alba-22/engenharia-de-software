import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:turistando/app/core/components/appbar/common_appbar.dart';
import 'package:turistando/app/core/components/buttons/common_button.dart';
import 'package:turistando/app/core/components/fields/common_field.dart';
import 'package:turistando/app/core/components/layout/place_card.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/core/utils/custom_colors.dart';

import 'stores/create_tour_store.dart';
import 'stores/delete_place_from_current_tour_store.dart';
import 'stores/get_places_in_current_tour_store.dart';

class CreateTourPage extends StatefulWidget {
  const CreateTourPage({Key? key}) : super(key: key);

  @override
  State<CreateTourPage> createState() => _CreateTourPageState();
}

class _CreateTourPageState extends State<CreateTourPage> {
  final getStore = locator.get<GetPlacesInCurrentTourStore>();
  final deleteStore = locator.get<DeletePlaceFromCurrentTourStore>();
  final createStore = locator.get<CreateTourStore>();

  final formKey = GlobalKey<FormState>();

  final tourNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getStore.getPlacesInCurrentTour();
    deleteStore.addListener(() {
      if (deleteStore.value is DeletePlaceFromCurrentTourSuccessState) {
        getStore.getPlacesInCurrentTour();
      } else if (deleteStore.value is DeletePlaceFromCurrentTourErrorState) {
        FToast.toast(
          context,
          msg: (deleteStore.value as DeletePlaceFromCurrentTourErrorState).message,
        );
      }
    });
    createStore.addListener(() {
      if (createStore.value is CreateTourSuccessState) {
        FToast.toast(
          context,
          color: CColors.green,
          msg: "Tour criado com sucesso!",
        );
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "MEU TOUR",
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                "NOME DO TOUR",
                style: TextStyle(
                  color: CColors.title,
                  fontWeight: FWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              CommonField(
                controller: tourNameController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "O nome do tour é obrigatório!";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "LOCAIS ADICIONADOS",
                style: TextStyle(
                  color: CColors.title,
                  fontWeight: FWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: getStore,
                  builder: (context, GetPlacesInCurrentTourState getState, child) {
                    if (getState is GetPlacesInCurrentTourLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (getState is GetPlacesInCurrentTourEmptyState) {
                      return const Center(child: Text("Não há nenhum local na lista ainda"));
                    } else if (getState is GetPlacesInCurrentTourSuccessState) {
                      return ValueListenableBuilder(
                        valueListenable: deleteStore,
                        builder: (context, DeletePlaceFromCurrentTourState deleteState, child) {
                          if (deleteState is DeletePlaceFromCurrentTourLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.separated(
                            itemCount: getState.places.length,
                            itemBuilder: (BuildContext context, int index) {
                              final place = getState.places[index];

                              return PlaceCard(
                                place: place,
                                onDelete: () {
                                  deleteStore.deletePlaceFromCurrentTour(place);
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: 8);
                            },
                          );
                        },
                      );
                    }
                    final value = getState as GetPlacesInCurrentTourErrorState;

                    return Center(child: Text(value.message));
                  },
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: createStore,
                builder: (context, CreateTourState createState, child) {
                  return ValueListenableBuilder(
                    valueListenable: getStore,
                    builder: (context, GetPlacesInCurrentTourState getState, child) {
                      return CommonButton(
                        text: "CRIAR TOUR",
                        width: double.infinity,
                        isLoading: createState is CreateTourLoadingState,
                        onTap: () {
                          // ! ISSO AQUI TÁ HORRÍVEL
                          if (getState is GetPlacesInCurrentTourEmptyState) {
                            FToast.toast(
                              context,
                              msg: "Adicione um local para poder criar um tour!",
                            );
                          } else if ((formKey.currentState?.validate() ?? false) &&
                              getState is GetPlacesInCurrentTourSuccessState) {
                            createStore.createTour(tourNameController.text.trim(), getState.places);
                          }
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
