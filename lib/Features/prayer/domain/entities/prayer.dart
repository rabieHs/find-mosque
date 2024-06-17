// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Prayer extends Equatable {
  final String name;
  final String time;
  final String image;
  const Prayer({
    required this.name,
    required this.time,
    required this.image,
  });

  @override
  List<Object?> get props => [name, time, image];
}
