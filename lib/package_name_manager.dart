library package_name_manager;

import 'src/android_rename_steps.dart';
import 'src/ios_rename_steps.dart';
import 'src/utils/package_manager_exception.dart';
import 'src/utils/package_name_validator.dart';

/// Main class for managing package name changes across Android and iOS platforms.
///
/// Provides static methods to execute package renaming operations based on command-line arguments.
/// Handles argument validation, platform-specific operations, and error handling.
class PackageNameManager {

  /// Executes the package renaming process based on provided arguments.
  ///
  /// [arguments] should contain:
  /// - At minimum: [newPackageName]
  /// - Optionally: [--android] or [--ios] platform flag
  ///
  /// Throws:
  /// - [MissingPackageNameException] if no package name is provided
  /// - [TooManyArgumentsException] if more than 2 arguments are provided
  /// - [InvalidPlatformException] for invalid platform flags
  /// - [RenameOperationException] for failures during rename operations
  static Future<void> executeRename(List<String> arguments) async {
    try {
      _validateArguments(arguments);
      await _processRename(arguments);
    } on PackageManagerException {
      rethrow;
    } catch (e) {
      throw RenameOperationException('general', e);
    }
  }

  /// Validates command-line arguments according to package requirements
  ///
  /// Ensures:
  /// - At least one argument (package name) is provided
  /// - Validate package name format
  /// - Maximum of two arguments (package name + platform flag)
  /// - Valid platform flag when provided (--android or --ios)
  static void _validateArguments(List<String> arguments) {
    if (arguments.isEmpty) {
      throw const MissingPackageNameException();
    }

    final validation = PackageNameValidator.validate(arguments[0]);
    if (!validation.isValid) {
      throw InvalidPackageNameException(validation.errorMessage!);
    }

    if (arguments.length > 2) {
      throw const TooManyArgumentsException();
    }

    if (arguments.length == 2) {
      final platform = arguments[1].toLowerCase();
      if (platform != '--android' && platform != '--ios') {
        throw InvalidPlatformException(arguments[1]);
      }
    }
  }

  /// Determines and executes the appropriate rename operation based on arguments
  ///
  /// Routes to either:
  /// - Full platform rename when only package name is provided
  /// - Platform-specific rename when platform flag is included
  static Future<void> _processRename(List<String> arguments) async {
    final newPackageName = arguments[0];

    arguments.length == 1
        ? await _renameAllPlatforms(newPackageName)
        : await _renameSpecificPlatform(newPackageName, arguments[1]);
  }

  /// Executes rename operations for both Android and iOS platforms
  ///
  /// [newPackageName]: The target package name/bundle identifier
  ///
  /// Throws [RenameOperationException] if any platform operation fails
  static Future<void> _renameAllPlatforms(String newPackageName) async {
    try {
      await AndroidRenameSteps(newPackageName).execute();
      await IosRenameSteps(newPackageName).execute();
    } catch (e) {
      throw RenameOperationException('all platforms', e);
    }
  }

  /// Executes rename operation for a specific platform
  ///
  /// [newPackageName]: The target package name/bundle identifier
  /// [platformFlag]: Platform specification flag (--android or --ios)
  ///
  /// Throws [RenameOperationException] with platform context if operation fails
  static Future<void> _renameSpecificPlatform(
      String newPackageName, String platformFlag) async {
    final platform = platformFlag.toLowerCase();
    try {
      if (platform == '--android') {
        await AndroidRenameSteps(newPackageName).execute();
      } else {
        await IosRenameSteps(newPackageName).execute();
      }
    } catch (e) {
      throw RenameOperationException(platform.replaceAll('--', ''), e);
    }
  }
}
