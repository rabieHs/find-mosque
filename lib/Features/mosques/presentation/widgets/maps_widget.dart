import 'dart:io';

import 'package:find_mosques/Features/mosques/presentation/controllers/bloc/maps_bloc.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:find_mosques/core/injection/dependecy_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatelessWidget {
  const MapsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MapsBloc>(),
      child: BlocConsumer<MapsBloc, MapsState>(
        listener: (context, state) {
          if (state is ShowMosqueInfoState) {
            showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                      width: double.infinity,
                      height: context.screenHeight() * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/icons/marker_6.png",
                            width: 150,
                            height: 150,
                            scale: 1,
                          ),
                          Text(
                            state.mosqueName,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/icons/man.png"),
                              Image.asset("assets/icons/women.png"),
                            ],
                          )
                        ],
                      ),
                    ));
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<MapsBloc>(context);

          return Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: GoogleMap(
              onCameraMove: (position) {
                bloc.add(GetAllMosquesEventOnCameraMove(
                  cameraPosition: position,
                ));
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: bloc.currentPosition,
              markers: BlocProvider.of<MapsBloc>(context).markers,
              onMapCreated: (controller) {
                bloc.add(InitializeMapsEvent(controller: controller));
              },
            ),
          );
        },
      ),
    );
  }
}
