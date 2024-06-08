import 'package:find_mosques/Features/mosques/presentation/controllers/bloc/maps_bloc.dart';
import 'package:find_mosques/core/injection/dependecy_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatelessWidget {
  const MapsWidget({
    super.key,
    required CameraPosition kGooglePlex,
  }) : _kGooglePlex = kGooglePlex;

  final CameraPosition _kGooglePlex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MapsBloc>(),
      child: BlocConsumer<MapsBloc, MapsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) {
                BlocProvider.of<MapsBloc>(context)
                    .add(InitializeMapsEvent(controller: controller));
              },
            ),
          );
        },
      ),
    );
  }
}
