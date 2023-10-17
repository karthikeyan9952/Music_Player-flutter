import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(filter: null, printer: PrettyPrinter(), output: null);
GlobalKey appKey = GlobalKey();
GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
