extension StringExtensions on String {
  String capitalize(String word) {
    return "${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}";
  }
}
