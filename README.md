# Package Name Manager for Flutter 🚀

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/gnassro/package_name_manager.svg)](https://github.com/gnassro/package_name_manager)

A modern, maintained solution for managing Flutter application package names across platforms. Simplifies package renaming through a single command.

**Fork Notice**: This maintained version extends the original [change_app_package_name](https://pub.dev/packages/change_app_package_name)
to solve critical Android activity migration issues while preserving all existing functionality.

## Key Enhancement 🛠
Fixes the critical limitation of the original package where **custom Android activities** (beyond MainActivity)
remained in old package directories. Now handles:

- Multiple activity migration
- All activity file updates (Java/Kotlin)
- Complete package structure cleanup

## Features ✨

### Android Improvements
- ✅ Updates **all** activity files (MainActivity + custom activities)
- ✅ Maintains relationships between multiple activities
- ✅ Full directory structure migration for all activities
- ✅ Automatic old package directory cleanup

### Core Functionality
- 🔄 iOS bundle identifier updates
- 📦 Gradle/Manifest file modifications
- 🖥️ Supports both Java and Kotlin projects
- 🚀 Single-command execution

## Installation 📦

Add to your `dev_dependencies`:

```yaml
dev_dependencies:
package_name_manager: ^1.0.0
```

Or install directly from GitHub:

```yaml
dev_dependencies:
  package_name_manager:
    git:
      url: https://github.com/gnassro/package_name_manager
      ref: master
```

Install via command line:
```bash
flutter pub add -d package_name_manager
```

## Usage 🛠

**Basic Rename (Both Platforms):**
```bash
dart run package_name_manager:main com.your.new.package
```

**Android-specific Rename:**
```bash
dart run package_name_manager:main com.android.package --android
```

**iOS-specific Rename:**
```bash
dart run package_name_manager:main com.ios.bundle --ios
```

## Issues and Feedback

Please file any issues or feedback [here](https://github.com/gnassro/package_name_manager/issues).