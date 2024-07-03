class Data {
  final double temperature;
  final double humidity;
  final double pressure;
  final double altitude;

  const Data({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.altitude,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        temperature: json["temperature"],
        humidity: json["humidity"],
        pressure: json["pressure"],
        altitude: json["altitude"],
    );
  }
}