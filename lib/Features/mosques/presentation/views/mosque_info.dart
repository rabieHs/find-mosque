// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/views/add_mosque_info.dart';
import 'package:find_mosques/core/methods/messages.dart';
import 'package:flutter/material.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/mosque_info_widget.dart';

class MosqueInfo extends StatelessWidget {
  final Location location;
  const MosqueInfo({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MosqueBloc, MosqueState>(
      listener: (context, state) {
        if (state is ErrorGetMosqueState) {
          showErrorMessage(context, state.message);
        }
      },
      builder: (context, state) {
        print(state.runtimeType);

        return SizedBox(
          width: double.infinity,
          height: context.screenHeight() * 0.6,
          child: state is SuccessGetMosqueState
              ? _buildMosqueInfoContainer(state.mosque)
              : _buildAddMosqueInfoContainer(context),
        );
      },
    );
  }

  Widget _buildAddMosqueInfoContainer(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/icons/search_icon.png",
            width: 75,
            height: 75,
            scale: 1,
          ),
          Text(
            "there is no info for this mosque",
          ),
          Text(
            "please help us and add info for this mosque",
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SizedBox(
                      height: context.screenHeight() * 0.65,
                      child: AddMosqueInfo(
                        location: location,
                      )));
            },
            child: Text("add"),
          )
        ]);
  }

  Widget _buildMosqueInfoContainer(Mosque mosque) {
    return MosqueInfoWidget(
      location: location,
      mosque: mosque,
    );
  }
}
