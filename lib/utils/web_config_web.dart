import 'package:web/web.dart' as web;

/// The Jellyfin server suggested by the page serving the web build, from `<meta name="finamp-server-url">` in
/// web/index.html. A path such as "/jellyfin" is resolved against the page's address.
String? suggestedServerUrl() {
  final content = web.document.querySelector('meta[name="finamp-server-url"]')?.getAttribute("content")?.trim();
  if (content == null || content.isEmpty) return null;
  return Uri.base.resolve(content).toString();
}
