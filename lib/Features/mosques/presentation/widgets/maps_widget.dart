// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:find_mosques/core/injection/dependecy_injection.dart';
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
        if (state is ShowMosqueLocationState) {
          print("showing dialog");
          BlocProvider.of<MosqueBloc>(context)
              .add(GetMosqueInfoEvent(location: state.location));
          showModalBottomSheet(
              context: context,
              builder: (context) => MosqueInfo(
                    location: state.location,
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
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: GoogleMap(
            onCameraMove: (position) {
              if (state is! SuccessNavigateState)
                bloc.add(GetAllMosquesEventOnCameraMove(
                  cameraPosition: position,
                ));
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            polylines:
                state is SuccessNavigateState ? bloc.polylineCoordinates : {},
            initialCameraPosition: bloc.currentPosition,
            markers: BlocProvider.of<MapsBloc>(context).markers,
            onMapCreated: (controller) {
              bloc.add(InitializeMapsEvent(controller: controller));
            },
          ),
        );
      },
    );
  }
}
