import 'dart:io';

import '../lib/src/utils/package_manager_exception.dart';
import '../lib/package_name_manager.dart';

void main(List<String> args) async {
  try {
    await PackageNameManager.executeRename(args);
    print('Package name changed successfully!');
  } on PackageManagerException catch (e) {
    print('ERROR: ${e.message}');
    exit(exitCode);
  }
}
