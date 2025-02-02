# Package Name Manager for Flutter 🚀

<p align="center">
<a href="https://www.buymeacoffee.com/gnassro" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width=120 ></a><br>
  <a href="https://pub.dev/packages/package_name_manager"><img src="https://img.shields.io/pub/v/package_name_manager.svg" alt="Pub"></a>
  <a href="https://github.com/gnassro/package_name_manager/blob/master/LICENSE"><img src="https://img.shields.io/github/license/gnassro/package_name_manager" alt="BSD 3-Clause License"></a>
  <a href="https://github.com/gnassro/package_name_manager"><img src="https://img.shields.io/github/stars/gnassro/package_name_manager?style=social" alt="Pub"></a><br>
  <a href="https://pub.dev/packages/package_name_manager/score"><img src="https://img.shields.io/pub/likes/package_name_manager?logo=flutter" alt="Pub likes"></a>
  <a href="https://pub.dev/packages/package_name_manager/score"><img src="https://img.shields.io/pub/dm/package_name_manager?logo=flutter" alt="Pub popularity"></a>
  <a href="https://pub.dev/packages/package_name_manager/score"><img src="https://img.shields.io/pub/points/package_name_manager?logo=flutter" alt="Pub points"></a>
</p>


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