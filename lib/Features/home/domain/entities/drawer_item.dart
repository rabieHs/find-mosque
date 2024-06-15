// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DrawerItem extends Equatable {
  final String title;
  final IconData icon;
  final int id;
  const DrawerItem({
    required this.id,
    required this.title,
    required this.icon,
  });

  @override
  List<Object?> get props => [title, icon, id];
}
