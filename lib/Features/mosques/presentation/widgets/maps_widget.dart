// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/Features/prayer/presentation/controllers/bloc/prayer_bloc.dart';
import 'package:find_mosques/core/methods/messages.dart';
import 'package:find_mosques/core/widgets/circle_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import '../controllers/mosque_bloc/mosque_bloc.dart';
import '../views/mosque_info.dart';

class MapsWidget extends StatelessWidget {
  const MapsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapsBloc, MapsState>(
      listener: (context, state) {
        print(state.runtimeType);
        if (state is ShowMosqueLocationState) {
          BlocProvider.of<MosqueBloc>(context).add(
              GetMosqueInfoEvent(location: state.location, context: context));
          showModalBottomSheet(
              context: context,
              builder: (context) => MosqueInfo(
                    location: state.location,
                  ));
        }
        if (state is MosquesLocationErrorState) {
          showErrorMessage(context, state.message);
        } else if (state is MosquesLoadedState) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<MapsBloc>(context);

        return Stack(
          // fit: StackFit.expand,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: GoogleMap(
                zoomControlsEnabled: true,
                style: bloc.style,
                onCameraMove: (position) {
                  if (state is! SuccessNavigateState) {
                    bloc.add(GetAllMosquesEventOnCameraMove(
                      context: context,
                      cameraPosition: position,
                    ));
                  } else {
                    print("maps already loaded");
                  }
                },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                polylines: state is SuccessNavigateState
                    ? bloc.polylineCoordinates
                    : {},
                initialCameraPosition: bloc.currentPosition,
                markers: BlocProvider.of<MapsBloc>(context).markers,
                onMapCreated: (controller) {
                  if (state is! MosquesLoadedState &&
                      state is! MosquesLoadingState) {
                    bloc.add(InitializeMapsEvent(controller: controller));
                  } else {
                    print("maps already initialized");
                  }
                },
              ),
            ),
            state is SuccessNavigateState
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: CircleProgressButton(
                        onTap: () {
                          BlocProvider.of<MapsBloc>(context)
                              .add(CancelNavigationEvent());
                        },
                        forgroundColor: Colors.red,
                        backgroundColor: Colors.red,
                        icon: Icons.close,
                      ),
                    ))
                : SizedBox.shrink()
          ],
        );
      },
    );
  }
}
