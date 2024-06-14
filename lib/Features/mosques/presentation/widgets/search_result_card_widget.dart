import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/suggestion.dart';
import '../controllers/maps_bloc/maps_bloc.dart';

class SearchResultCard extends StatelessWidget {
  final Suggestion suggestion;
  const SearchResultCard({
    Key? key,
    required this.suggestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        BlocProvider.of<MapsBloc>(context).add(MoveCameraToSearchedPlaceEvent(
            id: suggestion.placeId, context: context));
      },
      leading: const Icon(Icons.location_on),
      title: Text(suggestion.name),
    );
  }
}
