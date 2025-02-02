class PackageNameValidator {
  /// Regular expression for valid package names (Android/iOS)
  /// Allows: lowercase letters, numbers, underscores, and dots
  /// Requires: at least two segments (e.g., com.example)
  static final _packageNameRegExp = RegExp(
    r'^([a-z_]{1}[a-z0-9_]*(\.[a-z_]{1}[a-z0-9_]*)+)$',
  );

  /// Validates a package name against basic format requirements
  ///
  /// Returns [ValidationResult] with:
  /// - isValid: whether the package name is valid
  /// - errorMessage: detailed error description if invalid
  static ValidationResult validate(String packageName) {
    if (packageName.isEmpty) {
      return ValidationResult(false, 'Package name cannot be empty');
    }

    if (!_packageNameRegExp.hasMatch(packageName)) {
      return ValidationResult(
          false,
          'Invalid package name format. Must be lowercase with at least two segments '
          '(e.g., "com.example"). Only letters, numbers, underscores, and dots allowed.');
    }

    final segments = packageName.split('.');
    for (final segment in segments) {
      if (segment.isEmpty) {
        return ValidationResult(false, 'Package name contains empty segments');
      }

      if (segment.startsWith(RegExp(r'^\d'))) {
        return ValidationResult(
            false, 'Segment "$segment" cannot start with a number');
      }
    }

    return ValidationResult(true);
  }
}

class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult(this.isValid, [this.errorMessage]);
}
