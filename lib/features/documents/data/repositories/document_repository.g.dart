// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentRepositoryHash() =>
    r'ff1e7ec12c60bbe40af74b294bb93694a626ee89';

/// See also [documentRepository].
@ProviderFor(documentRepository)
final documentRepositoryProvider =
    AutoDisposeProvider<DocumentRepository>.internal(
  documentRepository,
  name: r'documentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$documentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DocumentRepositoryRef = AutoDisposeProviderRef<DocumentRepository>;
String _$activeCarDocumentsHash() =>
    r'c51a3b61ecb6525c881f8185a8a29f2b853fbc60';

/// Streams documents for the currently active car.
///
/// Copied from [activeCarDocuments].
@ProviderFor(activeCarDocuments)
final activeCarDocumentsProvider =
    AutoDisposeStreamProvider<List<DocumentReminder>>.internal(
  activeCarDocuments,
  name: r'activeCarDocumentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeCarDocumentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActiveCarDocumentsRef
    = AutoDisposeStreamProviderRef<List<DocumentReminder>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
