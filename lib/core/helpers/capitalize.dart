extension Capitalize on String {
  String capitalize() {
    if (isEmpty) return this;

    // Check if the first character is a letter (basic English check)
    if (!RegExp(r'^[a-zA-Z]').hasMatch(this)) {
      return this; // Return as is if not an English letter
    }

    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
