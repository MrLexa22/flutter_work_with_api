import 'package:flutter/cupertino.dart';
import 'package:flutter_work_with_api/app/domain/app_builder.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../di/init_di.dart';
import '../domain/app_runner.dart';

class MainAppRunner implements AppRunner {
  final String env;

  MainAppRunner(this.env);
  @override
  Future<void> preloadData() async {
    //init app
    initDi(env);
    //init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    final storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory());
    HydratedBlocOverrides.runZoned(
      () async {
        await preloadData();
        runApp(appBuilder.buildApp());
      },
      storage: storage,
    );
  }
}