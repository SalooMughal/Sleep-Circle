class NewAlarmSettings {
  final int id;
  final DateTime dateTime;
  final String assetAudioPath;
  final bool loopAudio;
  final bool vibrate;
  final double? volume;
  final String notificationTitle;
  final String notificationBody;

  NewAlarmSettings({
    required this.id,
    required this.dateTime,
    required this.assetAudioPath,
    required this.loopAudio,
    required this.vibrate,
    this.volume,
    required this.notificationTitle,
    required this.notificationBody,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'assetAudioPath': assetAudioPath,
      'loopAudio': loopAudio,
      'vibrate': vibrate,
      'volume': volume,
      'notificationTitle': notificationTitle,
      'notificationBody': notificationBody,
    };
  }

  factory NewAlarmSettings.fromJson(Map<String, dynamic> json) {
    return NewAlarmSettings(
      id: json['id'],
      dateTime: DateTime.parse(json['dateTime']),
      assetAudioPath: json['assetAudioPath'],
      loopAudio: json['loopAudio'],
      vibrate: json['vibrate'],
      volume: json['volume'],
      notificationTitle: json['notificationTitle'],
      notificationBody: json['notificationBody'],
    );
  }
}
