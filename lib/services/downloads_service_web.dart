import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/finamp_models.dart';
import '../models/jellyfin_models.dart';
import 'downloads_service.dart';

/// Streaming-only stand-in for [DownloadsService] in the web build, which has neither Isar nor a file system.
/// Nothing is ever downloaded, so every query answers "not downloaded" and every request to download is ignored.
class WebDownloadsService extends DownloadsService {
  WebDownloadsService() : super.withoutStorage();

  @override
  final stateProvider = StreamProvider.family.autoDispose<DownloadItemState?, DownloadStub>(
    (ref, stub) => Stream.value(null),
  );

  @override
  late final statusProvider = Provider.family.autoDispose<DownloadItemStatus, (DownloadStub, int?)>(
    (ref, record) => DownloadItemStatus.notNeeded,
  );

  @override
  final itemProvider = StreamProvider.family.autoDispose<DownloadItem?, DownloadStub>(
    (ref, stub) => Stream.value(null),
  );

  @override
  late final userDownloadedItemsProvider = Provider.family.autoDispose<List<DownloadStub>, DownloadsScreenCategory>(
    (ref, category) => const [],
  );

  @override
  bool get allowSyncs => false;

  @override
  Future<void> startQueues() async {}

  @override
  void restartDownloads() {}

  @override
  void updateDownloadCounts() {}

  @override
  Future<void> addDownload({
    required DownloadStub stub,
    required DownloadProfile transcodeProfile,
    BaseItemId? viewId,
  }) async {}

  @override
  Future<void> deleteDownload({required DownloadStub stub}) async {}

  @override
  Future<void> resync(DownloadStub stub, BaseItemId? viewId, {bool keepSlow = false, bool forceSync = false}) async {}

  @override
  Future<void> resyncAll({bool forceSync = false}) async {}

  @override
  Future<void> repairAllDownloads() async {}

  @override
  Future<void> migrateFromHive() async {}

  @override
  Future<void> addDefaultPlaylistInfoDownload() async {}

  @override
  DownloadItemStatus getStatus(DownloadStub stub, int? children) => DownloadItemStatus.notNeeded;

  @override
  Future<List<DownloadStub>> getAllCollections({
    String? nameFilter,
    List<BaseItemDtoType> includeItemTypes = const [],
    BaseItemDto? relatedTo,
    bool fullyDownloaded = false,
    BaseItemId? viewFilter,
    BaseItemId? childViewFilter,
    bool nullableViewFilters = true,
    bool onlyFavorites = false,
    BaseItemDtoType? infoForType,
    ArtistType? artistType,
    BaseItemId? genreFilter,
  }) async => const [];

  @override
  Future<List<BaseItemDto>> getCollectionTracks(
    BaseItemDto item, {
    bool playable = true,
    BaseItemId? genreFilter,
    bool onlyFavorites = false,
  }) async => const [];

  @override
  Future<List<DownloadStub>> getAllTracks({
    String? nameFilter,
    BaseItemDto? relatedTo,
    BaseItemId? viewFilter,
    bool nullableViewFilters = true,
    bool onlyFavorites = false,
    BaseItemId? genreFilter,
  }) async => const [];

  @override
  Future<DownloadStub?> getCollectionInfo({BaseItemDto? item, BaseItemId? id}) async => null;

  @override
  Future<DownloadStub?> getTrackInfo({BaseItemDto? item, BaseItemId? id}) async => null;

  @override
  DownloadItem? getTrackDownload({BaseItemDto? item, BaseItemId? id}) => null;

  @override
  DownloadItem? getImageDownload({BaseItemDto? item, String? blurHash}) => null;

  @override
  Future<DownloadedLyrics?> getLyricsDownload({required BaseItemDto baseItem}) async => null;

  @override
  Stream<List<DownloadStub>> getDownloadList(DownloadItemState state) => Stream.value(const []);

  @override
  Future<int> getFileSize(DownloadStub item) async => 0;

  @override
  DownloadStub? getFirstRequiringItem(DownloadStub stub) => null;

  @override
  List<DownloadStub> getVisibleChildren(DownloadStub stub) => const [];

  @override
  List<DownloadStub> getDownloadsForLocation(String downloadLocationId, bool checkFiles) => const [];

  @override
  int? getFavoritesCount({BaseItemDtoType? baseItemType}) => null;

  @override
  bool? isFavorite(BaseItemDto item) => null;

  @override
  bool? checkIfInCollection(BaseItemDto collection, BaseItemDto item) => null;
}
