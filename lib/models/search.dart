import 'package:arcadi/models/dictionary.dart';

class SearchResult {
  const SearchResult({required this.id, required this.name, required this.isMarker});
  final int id;
  final String name;
  final bool isMarker;

  factory SearchResult.toSearchObj(Analyze analysis, bool isMarker) {
    return SearchResult(
      id: analysis.id,
      name: analysis.name,
      isMarker: isMarker,
    );
  }

  static List<SearchResult> convertAnalyzes(List<Analyze> list) {
    List<SearchResult> results = [];
    for (final l in list) {
      results.add(SearchResult(id: l.id, name: l.name, isMarker: false));
    }
    return results;
  }

  static List<SearchResult> convertMarkers(List<Marker> list) {
    List<SearchResult> results = [];
    for (final l in list) {
      results.add(SearchResult(id: l.id, name: l.name, isMarker: true));
    }
    return results;
  }
}
