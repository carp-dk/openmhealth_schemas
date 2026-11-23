/// Access to the upstream IEEE 1752 (GitLab) and Open mHealth (GitHub)
/// repositories, used to load schemas and test data directly from the source.
library;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

/// Thrown when an upstream repository cannot be reached.
class UpstreamException implements Exception {
  final String message;
  UpstreamException(this.message);

  @override
  String toString() => 'Upstream repository not reachable: $message';
}

final HttpClient _client = HttpClient()
  ..connectionTimeout = const Duration(seconds: 20)
  // The IEEE GitLab server rejects the default Dart user agent (HTTP 418).
  ..userAgent = 'openmhealth-schemas-tests';

/// Gets the text at [url].
///
/// Upstream servers occasionally reset connections, e.g. when many tests
/// fetch files at the same time. Hence, failed requests are retried up to
/// three times, with an increasing delay.
Future<String> getText(Uri url) async {
  const attempts = 4;
  Object? lastError;
  for (var attempt = 1; attempt <= attempts; attempt++) {
    if (attempt > 1) {
      await Future<void>.delayed(
        Duration(milliseconds: 500 * (1 << (attempt - 2))),
      );
    }
    try {
      final request = await _client.getUrl(url);
      final response = await request.close().timeout(
        const Duration(seconds: 30),
      );
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.ok) return body;
      lastError = 'HTTP ${response.statusCode}';
    } catch (error) {
      lastError = error;
    }
  }
  throw UpstreamException('$url ($lastError)');
}

/// Gets and decodes the JSON at [url].
Future<Object?> getJson(Uri url) async => json.decode(await getText(url));

/// The IEEE 1752 repository at https://opensource.ieee.org/omh/1752
class Ieee {
  static const String _api =
      'https://opensource.ieee.org/api/v4/projects/omh%2F1752/repository/tree';

  /// The URL of the raw file at [path] in the repository.
  static Uri raw(String path) =>
      Uri.parse('https://opensource.ieee.org/omh/1752/-/raw/main/$path');

  /// The paths of all files in the folder [path], including sub-folders.
  static Future<List<String>> list(String path) async {
    const perPage = 100;
    final files = <String>[];
    for (var page = 1; ; page++) {
      final items =
          await getJson(
                Uri.parse(
                  '$_api?path=$path&recursive=true&per_page=$perPage&page=$page',
                ),
              )
              as List<dynamic>;
      files.addAll(
        items
            .cast<Map<String, dynamic>>()
            .where((item) => item['type'] == 'blob')
            .map((item) => item['path'] as String),
      );
      if (items.length < perPage) break;
    }
    return files..sort();
  }
}

/// The Open mHealth schema repository at https://github.com/openmhealth/schemas
class Omh {
  /// The URL of the raw file at [path] in the repository.
  static Uri raw(String path) => Uri.parse(
    'https://raw.githubusercontent.com/openmhealth/schemas/main/$path',
  );

  /// The paths of all files in the repository.
  static Future<List<String>> list() async {
    final tree =
        await getJson(
              Uri.parse(
                'https://api.github.com/repos/openmhealth/schemas/git/trees/main?recursive=1',
              ),
            )
            as Map<String, dynamic>;
    if (tree['truncated'] == true) {
      throw UpstreamException('the GitHub file listing was truncated');
    }
    return (tree['tree'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .where((item) => item['type'] == 'blob')
        .map((item) => item['path'] as String)
        .toList()
      ..sort();
  }
}

/// Starts fetching the JSON at all [urls], at most [parallel] at a time.
///
/// Returns a future per URL. Errors are delivered when the future is awaited.
Map<K, Future<Object?>> prefetch<K>(Map<K, Uri> urls, {int parallel = 8}) {
  final pool = _Pool(parallel);
  return {
    for (final entry in urls.entries)
      entry.key: pool.run(() => getJson(entry.value))..ignore(),
  };
}

/// Limits the number of tasks running at the same time.
class _Pool {
  final int size;
  int _running = 0;
  final Queue<Completer<void>> _waiting = Queue();

  _Pool(this.size);

  Future<T> run<T>(Future<T> Function() task) async {
    if (_running >= size) {
      final turn = Completer<void>();
      _waiting.add(turn);
      await turn.future;
    }
    _running++;
    try {
      return await task();
    } finally {
      _running--;
      if (_waiting.isNotEmpty) _waiting.removeFirst().complete();
    }
  }
}
