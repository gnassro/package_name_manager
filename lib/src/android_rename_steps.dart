import 'dart:async';
import 'dart:io';

import 'utils/file_utils.dart';

class AndroidRenameSteps {
  final String newPackageName;
  String? oldPackageName;

  static const String PATH_BUILD_GRADLE = 'android/app/build.gradle';
  static const String PATH_MANIFEST =
      'android/app/src/main/AndroidManifest.xml';
  static const String PATH_MANIFEST_DEBUG =
      'android/app/src/debug/AndroidManifest.xml';
  static const String PATH_MANIFEST_PROFILE =
      'android/app/src/profile/AndroidManifest.xml';

  static const String PATH_ACTIVITY = 'android/app/src/main/';

  AndroidRenameSteps(this.newPackageName);

  Future<void> execute() async {
    print("Running for android");
    if (!await File(PATH_BUILD_GRADLE).exists()) {
      print(
          'ERROR:: build.gradle file not found, Check if you have a correct android directory present in your project'
          '\n\nrun " flutter create . " to regenerate missing files.');
      return;
    }
    String? contents = await readFileAsString(PATH_BUILD_GRADLE);

    var reg = RegExp(r'applicationId\s*=?\s*"(.*)"',
        caseSensitive: true, multiLine: false);
    var match = reg.firstMatch(contents!);
    if (match == null) {
      print(
          'ERROR:: applicationId not found in build.gradle file, Please file an issue on github with $PATH_BUILD_GRADLE file attached.');
      return;
    }
    var name = match.group(1);
    oldPackageName = name;

    print("Old Package Name: $oldPackageName");

    print('Updating build.gradle File');
    await _replace(PATH_BUILD_GRADLE);

    var mText = 'package="$newPackageName">';
    var mRegex = '(package=.*)';

    print('Updating Main Manifest file');
    await replaceInFileRegex(PATH_MANIFEST, mRegex, mText);

    print('Updating Debug Manifest file');
    await replaceInFileRegex(PATH_MANIFEST_DEBUG, mRegex, mText);

    print('Updating Profile Manifest file');
    await replaceInFileRegex(PATH_MANIFEST_PROFILE, mRegex, mText);

    await updateActivities();
    print('Finished updating android package name');
  }

  Future<void> updateActivities() async {
    var files = await findActivities(type: 'java');

    for (var file in files) {
      await processActivities(file, 'java');
    }

    files = await findActivities(type: 'kotlin');
    for (var file in files) {
      await processActivities(file, 'kotlin');
    }
  }

  Future<List<File>> findActivities({required String type}) async {
    var files = await dirContents(Directory(PATH_ACTIVITY + type));
    String extension = type == 'java' ? 'java' : 'kt';
    final List<File> filesToReturn = [];
    for (var item in files) {
      if (item is File) {
        String? oldPackagePath = oldPackageName?.replaceAll('.', '/');
        if (oldPackagePath != null &&
            item.path.contains(oldPackagePath) &&
            item.path.endsWith('.' + extension)) {
          filesToReturn.add(item);
        }
      }
    }
    return filesToReturn;
  }

  Future<void> processActivities(File path, String type) async {
    var fileName = path.path.split('/').last;
    print('Project is using $type');
    print('Updating $fileName');
    await replaceInFileRegex(
        path.path, '(package.*)', "package ${newPackageName}");

    String newPackagePath = newPackageName.replaceAll('.', '/');
    String newPath = '${PATH_ACTIVITY}${type}/$newPackagePath';

    print('Creating New Directory Structure');
    await Directory(newPath).create(recursive: true);
    await path.rename(newPath + '/$fileName');

    print('Deleting old directories');

    await deleteEmptyDirs(type);
  }

  Future<void> _replace(String path) async {
    await replaceInFile(path, oldPackageName, newPackageName);
  }

  Future<void> deleteEmptyDirs(String type) async {
    var dirs = await dirContents(Directory(PATH_ACTIVITY + type));
    dirs = dirs.reversed.toList();
    for (var dir in dirs) {
      if (dir is Directory) {
        if (dir.existsSync() && dir.listSync().toList().isEmpty) {
          dir.deleteSync();
        }
      }
    }
  }

  Future<List<FileSystemEntity>> dirContents(Directory dir) {
    if (!dir.existsSync()) return Future.value([]);
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: true);
    lister.listen((file) => files.add(file),
        // should also register onError
        onDone: () => completer.complete(files));
    return completer.future;
  }
}
