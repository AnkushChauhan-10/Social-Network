import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_network/core/di/injection.dart';
import 'package:social_network/core/env/env.dart';
import 'package:social_network/core/env/env_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseKey,
  );
  await Firebase.initializeApp();
  await configureDependencies();
  runApp(const App());
}
