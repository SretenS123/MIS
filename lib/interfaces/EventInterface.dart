

import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';
import '../models/Festival.dart';

abstract class FestivalInterface{
  List<Festival> getAll();
  Festival findById(int Id);
  void deleteFestival(Festival festival);

}