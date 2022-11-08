String formatSingleQuote(String jsonData) {
  return jsonData
      .replaceAll('\'', '\\\'')
      .replaceAllMapped(RegExp('([^\\\\])"'), (match) => '${match[1]}\'')
      .replaceAll('\\"', '"');
}
