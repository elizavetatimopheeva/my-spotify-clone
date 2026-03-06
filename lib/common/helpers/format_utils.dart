class FormatUtils {
  static String durationToMinutesSeconds(num duration) {
    int minutes = duration.truncate();
    int seconds = ((duration - minutes) * 100).round();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}