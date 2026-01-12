import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:petcare_express/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/core/database/hive_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveConfig.init();
  await initializeDateFormatting('pt_BR', '');
  Intl.defaultLocale = 'pt_BR';
  runApp(const MyApp());
}
