abstract class PackageManagerException implements Exception {
  final String message;
  const PackageManagerException(this.message);

  @override
  String toString() => 'PackageNameManagerError: $message';
}

class MissingPackageNameException extends PackageManagerException {
  const MissingPackageNameException() : super('New package name is required');
}

class InvalidPlatformException extends PackageManagerException {
  InvalidPlatformException(String platform)
      : super('Invalid platform "$platform". Use "--android" or "--ios"');
}

class TooManyArgumentsException extends PackageManagerException {
  const TooManyArgumentsException()
      : super('Maximum 2 arguments allowed: <new-package-name> [--platform]');
}

class RenameOperationException extends PackageManagerException {
  RenameOperationException(String platform, dynamic cause)
      : super(
            'Failed to rename $platform package: ${cause?.toString() ?? 'Unknown error'}');
}

class InvalidPackageNameException extends PackageManagerException {
  final String validationError;

  InvalidPackageNameException(this.validationError)
      : super('Invalid package name: $validationError');
}