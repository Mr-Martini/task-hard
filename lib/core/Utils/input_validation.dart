abstract class InputValidation {
  static bool isEmpty(text) {
    if (text == null || text == '') {
      return true;
    }
    if (text.trim().length == 0) {
      return true;
    }
    return false;
  }
}
